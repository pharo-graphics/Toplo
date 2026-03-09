Trait {
	#name : #TToAnnulusSectorLayoutUser,
	#category : #'Toplo-Widget-Circular'
}

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> innerRadialRatio [

	^ self stateHolder innerRadialRatio
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> innerRadialRatio: aFloat [

	(self innerRadialRatio closeTo: aFloat) ifTrue: [ ^ self ].
	self stateHolder innerRadialRatio: aFloat
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> innerRadius [

	self deprecated: 'Use #innerRadialRatio' transformWith: '`@rcvr innerRadius'->'`@rcvr innerRadialRatio'.
	^ self innerRadialRatio
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> innerRadius: aFloat [

	self
		deprecated: 'Use #innerRadialRatio:'
		transformWith:
		'`@rcvr innerRadius: `@arg' -> '`@rcvr innerRadialRatio: `@arg'.
	self innerRadialRatio: aFloat
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> outerRadialRatio [

	^ self stateHolder outerRadialRatio
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> outerRadialRatio: aFloat [

	(self outerRadialRatio closeTo: aFloat) ifTrue: [ ^ self ].
	self stateHolder outerRadialRatio: aFloat
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> outerRadius [

	self deprecated: 'Use #outerRadialRatio' transformWith: '`@rcvr outerRadius'->'`@rcvr outerRadialRatio'.
	^ self outerRadialRatio
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> outerRadius: aFloat [

	self
		deprecated: 'Use #outerRadialRatio:'
		transformWith:
		'`@rcvr outerRadius: `@arg' -> '`@rcvr outerRadialRatio: `@arg'.
	self outerRadialRatio: aFloat
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> startAngle [

	^ self stateHolder startAngle
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> startAngle: anAngleInDegrees [

	(self startAngle closeTo: anAngleInDegrees) ifTrue: [ ^ self ].
	self stateHolder startAngle: anAngleInDegrees.
	self requestLayout
]

{ #category : #'t - annulus sector layout user' }
TToAnnulusSectorLayoutUser >> stateHolder [

	^ self shouldBeImplemented 
]
