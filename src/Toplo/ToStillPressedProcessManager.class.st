Class {
	#name : #ToStillPressedProcessManager,
	#superclass : #ToSkinStateMouseEventProcessManager,
	#instVars : [
		'pickOutsideFilter'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'starting - stopping' }
ToStillPressedProcessManager >> checkEvent: anEvent [

	(process notNil and: [
		 (anEvent isKindOf: BlMouseUpEvent) or: [
			 anEvent isKindOf: ToPickOutsideEvent ] ]) ifTrue: [
		self stopProcessFromEvent: anEvent ]
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> generateStartStateFromEvent: anEvent [

	pickOutsideFilter := ToStillPressedPickOutsideEventFilter new
		                     element: skinStateGenerator target;
		                     yourself.
	skinStateGenerator target spaceDo: [ :sp |
		sp root addEventFilter: pickOutsideFilter ].
	super generateStartStateFromEvent: anEvent
]

{ #category : #accessing }
ToStillPressedProcessManager >> startDelay [

	^ self target stillPressedStartDelay
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> startStateSkinEventClass [

	^ ToStartStillPressedSkinEvent
]

{ #category : #'state generating' }
ToStillPressedProcessManager >> stateSkinEventClass [

	^ ToStillPressedSkinEvent
]

{ #category : #'starting - stopping' }
ToStillPressedProcessManager >> stopProcessFromEvent: anEvent [

	super stopProcessFromEvent: anEvent.
	pickOutsideFilter ifNil: [ ^ self ].
	pickOutsideFilter isInstalled ifTrue: [
		skinStateGenerator target spaceDo: [ :sp |
			sp root removeEventFilter: pickOutsideFilter ] ].
	pickOutsideFilter := nil.

]

{ #category : #'state generating' }
ToStillPressedProcessManager >> stopStateSkinEventClass [

	^ ToStopStillPressedSkinEvent
]
