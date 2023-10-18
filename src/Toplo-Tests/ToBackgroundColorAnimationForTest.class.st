Class {
	#name : 'ToBackgroundColorAnimationForTest',
	#superclass : 'ToPropertyAnimation',
	#category : 'Toplo-Tests-Core-Skin',
	#package : 'Toplo-Tests',
	#tag : 'Core-Skin'
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
