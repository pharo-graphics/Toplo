Class {
	#name : 'ToBackgroundColorAnimationForTest',
	#superclass : 'ToPropertyAnimation',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'running' }
ToBackgroundColorAnimationForTest >> stop [


]

{ #category : 'writing' }
ToBackgroundColorAnimationForTest >> write: anObject to: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 self duration asDelay wait.
			 self property write: anObject to: anElement.
			 self finishedHandlers do: [ :d | d value ] ])
]
