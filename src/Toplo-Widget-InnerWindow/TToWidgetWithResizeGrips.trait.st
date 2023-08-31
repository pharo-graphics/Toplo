Trait {
	#name : #TToWidgetWithResizeGrips,
	#category : #'Toplo-Widget-InnerWindow'
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
		 ToTopResizeGrip } collect: [ :eachClass |
			eachClass new target: self; yourself ]).

	self addChildren: self grips.

	self
		when: BlElementExtentChangedEvent
		do: [ :evt | self layoutGrips ]
]

{ #category : #'t - layout grips' }
TToWidgetWithResizeGrips >> layoutGrips [

	self grips do: [ :each | each layoutIn: self ]
]
