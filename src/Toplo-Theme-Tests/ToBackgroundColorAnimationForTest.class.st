Class {
	#name : #ToBackgroundColorAnimationForTest,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Theme-Tests-Skin'
}

{ #category : #running }
ToBackgroundColorAnimationForTest >> stop [


]

{ #category : #writing }
ToBackgroundColorAnimationForTest >> write: anObject to: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 self duration asDelay wait.
			 self property write: anObject to: anElement.
			 self finishedHandlers do: [ :d | d value ] ])
]
