Trait {
	#name : #TToWidgetWithResizeGrips,
	#category : #'Toplo-Widget-Window'
}

{ #category : #'t - accessing grips' }
TToWidgetWithResizeGrips >> grips [

	^ self userData at: #grips ifAbsent: [  ]
]

{ #category : #'t - accessing grips' }
TToWidgetWithResizeGrips >> grips: resizeGripList [

	self userData at: #grips put: resizeGripList
]

{ #category : #'t - initializing grips' }
TToWidgetWithResizeGrips >> initializeGrips [

	self grips: ({ 
			 ToBottomRightResizeGrip.
			 ToBottomLeftResizeGrip.
			 ToTopRightResizeGrip.
			 ToTopLeftResizeGrip.
			 ToRightResizeGrip.
			 ToLeftResizeGrip.
			 ToBottomResizeGrip.
			 ToTopResizeGrip } collect: [ :cls | cls new target: self ]).

	self addChildren: self grips.

	self
		when: BlElementExtentChangedEvent
		do: [ :evt | self layoutGrips ]
]

{ #category : #'t - layout grips' }
TToWidgetWithResizeGrips >> layoutGrips [

	self grips do: [ :g | g applyLayoutIn: self ]
]
