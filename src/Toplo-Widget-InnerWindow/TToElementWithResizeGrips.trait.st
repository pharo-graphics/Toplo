Trait {
	#name : 'TToElementWithResizeGrips',
	#category : 'Toplo-Widget-InnerWindow',
	#package : 'Toplo-Widget-InnerWindow'
}

{ #category : 't - element with resize grips - accessing' }
TToElementWithResizeGrips >> grips [

	^ self userData at: #grips ifAbsent: [  ]
]

{ #category : 't - element with resize grips - accessing' }
TToElementWithResizeGrips >> grips: resizeGripList [

	self userData at: #grips put: resizeGripList
]

{ #category : 't - element with resize grips -  initializing' }
TToElementWithResizeGrips >> initializeGrips [

	self grips: ({
			 ToBottomRightResizeGrip.
			 ToBottomLeftResizeGrip.
			 ToTopRightResizeGrip.
			 ToTopLeftResizeGrip.
			 ToRightResizeGrip.
			 ToLeftResizeGrip.
			 ToBottomResizeGrip.
			 ToTopResizeGrip } collect: [ :eachClass |
			 eachClass new
				 target: self;
				 yourself ]).

	self addChildren: self grips.

	self addEventHandler: (BlEventHandler
			 on: BlElementExtentChangedEvent
			 do: [ :evt | self layoutGrips ])
]

{ #category : 't - element with resize grips - layouting' }
TToElementWithResizeGrips >> layoutGrips [

	self grips do: [ :each | each layoutIn: self ]
]
