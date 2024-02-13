Class {
	#name : #ToBackgroundColorAnimationForTest,
	#superclass : #ToPropertyAnimation,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #writing }
ToBackgroundColorAnimationForTest >> newRawAnimationFor: anElement to: aValue [

	^ BlTaskAction new action: [
		  self duration asDelay wait.
		  self property write: anElement to: anElement ]
]

{ #category : #running }
ToBackgroundColorAnimationForTest >> stop [


]

{ #category : #writing }
ToBackgroundColorAnimationForTest >> write: anObject to: anElement [

	anElement enqueueTask: (BlTaskAction new action: [
			 self duration asDelay wait.
			 self property write: anObject to: anElement.
			 finishedAction ifNotNil: [:fa | fa value: anElement] ])
]
