﻿/*GTweenTimeline for GTween by Grant Skinner, gskinner.com/blog/This sample demonstrates advanced sequencing using GTweenTimeline, including addTween and addCallback.*/package  {		import com.gskinner.motion.*;	import com.gskinner.motion.plugins.*;	import com.gskinner.motion.easing.*;		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;		public class GTweenTimelineDemo extends MovieClip {			// Constants:			// Public Properties:			// Protected Properties:		protected var timeline:GTweenTimeline;			// Initialization:		public function GTweenTimelineDemo() {			// NOTE: FLA is set to automatically declare stage instances,			// so they are not listed in the properties above.						// install the motion blur plugin:			MotionBlurPlugin.install();						// exaggerate the motion blur effect:			MotionBlurPlugin.strength = 2;						// create the timeline:			timeline = new GTweenTimeline(null,0,null,{repeatCount:0,ease:Bounce.easeOut,reflect:true});						// note that these tweens could easily be created in a single line, but are expanded			// to show different approaches.			var tween:GTween = new GTween(pod,1,{scaleX:0,scaleY:0},{ease:Circular.easeOut});			tween.proxy.x += pod.width/2;			tween.proxy.y += pod.height/2;			// swap the values so it tweens from the specified location to it's current location:			tween.swapValues();			timeline.addTween(0,tween);						// notice that this tween has the repeatCount set to 0, so it will repeat indefinitely:			tween = new GTween(spinner,1,{rotation:-360},{repeatCount:0,reflect:false});			timeline.addTween(1,tween);						// likewise, tweens can be created and added to a timeline in a single line:			tween = new GTween(spinner,2,{alpha:0},{swapValues:true});			timeline.addTween(1,tween);						tween = new GTween(title,0.6,{alpha:0},{ease:Circular.easeOut});			tween.proxy.x += 100;			tween.swapValues();			timeline.addTween(0.9,tween);						tween = new GTween(newsPanel,0.5,{height:1,alpha:0},{ease:Circular.easeOut, swapValues:true});			timeline.addTween(1.4,tween);						tween = new GTween(tickerPanel,0.8,{width:1,alpha:0},{ease:Circular.easeOut, swapValues:true});			timeline.addTween(1.6,tween);						tween = new GTween(ticker,2,{alpha:0},{swapValues:true});			timeline.addTween(2.2,tween);						tween = new GTween(news,1,{alpha:0},{swapValues:true});			timeline.addTween(4,tween);						for (var i:int=0; i<6; i++) {				tween = new GTween(getChildByName("btn"+i),0.4,{alpha:0,scaleY:4},{ease:Circular.easeOut});				tween.proxy.y -= 120;				tween.swapValues();				timeline.addTween(3.2-i*0.1,tween);								// for these tweens, we will turn on motion blur. Motion blur is one of the few				// plugins that defaults to enabled=false. We need to override that by setting				// MotionBlurEnabled to true in the pluginData.				tween = new GTween(getChildByName("label"+i),0.6,{alpha:0,x:100},{ease:Circular.easeOut,swapValues:true},{MotionBlurEnabled:true});				timeline.addTween(3.6-i*0.1,tween);			}						// change the visibility of the page numbers using addCallback, and setPropertyValue:			// we'll be a little tricky here, and have put show/hide actions back to back,			// so that they show going forwards, and hide going backwards.			for (i=1; i<=3; i++) {				var pageObj:TextField = this["page"+i];				timeline.addCallback(5.0+i*0.15,GTweenTimeline.setPropertyValue,[pageObj,"visible",true],GTweenTimeline.setPropertyValue,[pageObj,"visible",false]);				// start out the page numbers with visible= false;				pageObj.visible = false;			}						// calculate the timeline duration based on all the tweens and callbacks:			timeline.calculateDuration();			// add a little bit of extra time on the end, so there's time to see the last page number come in before it reflects:			timeline.duration += 0.5;									// set up interactions:			slider.maximum = timeline.duration;			slider.snapInterval = 0.000001;			slider.liveDragging = true;			timeline.onChange = handleTimelineChange;			timeline.onComplete = handleTimelineComplete;			slider.addEventListener(Event.CHANGE,handleSliderChange);			playBtn.addEventListener(MouseEvent.CLICK,handlePlayClick);		}			// Public getter / setters:			// Public Methods:			// Protected Methods:		protected function handleTimelineChange(timeline:GTweenTimeline):void {			slider.value = timeline.calculatedPosition;		}				protected function handleTimelineComplete(timeline:GTweenTimeline):void {			playBtn.label = "play";		}				protected function handleSliderChange(evt:Event):void {			timeline.paused = true;			timeline.position = slider.value;			playBtn.label = "play";		}				protected function handlePlayClick(evt:Event):void {			timeline.paused = !timeline.paused;			playBtn.label = timeline.paused ? "play" : "pause";		}	}	}