Trait {
	#name : #TToAnnulusSectorLayoutState,
	#instVars : [
		'innerRadialRatio',
		'outerRadialRatio',
		'startAngle',
		'startAngleOffset'
	],
	#category : #'Toplo-Widget-Circular-Annulus'
}

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> innerRadialRatio [

	^ innerRadialRatio ifNil: [ innerRadialRatio := 0.0 ]
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> innerRadialRatio: aNormalizedRadius [

	innerRadialRatio := aNormalizedRadius
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> innerRadius [

	self deprecated: 'Use #innerRadialRatio' transformWith: '`@rcvr innerRadius'->'`@rcvr innerRadialRatio'.
	^ self innerRadialRatio
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> innerRadius: anObject [

	self
		deprecated: 'Use #innerRadialRatio:'
		transformWith:
		'`@rcvr innerRadius: `@arg' -> '`@rcvr innerRadialRatio: `@arg'.
	self innerRadialRatio: anObject
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> outerRadialRatio [

	^ outerRadialRatio ifNil: [ outerRadialRatio := 1.0 ]
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> outerRadialRatio: aNormalizedRadius [

	outerRadialRatio := aNormalizedRadius
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> outerRadius [

	self deprecated: 'Use #outerRadialRatio' transformWith: '`@rcvr outerRadius'->'`@rcvr outerRadialRatio'.
	^ self outerRadialRatio
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> outerRadius: anObject [

	self
		deprecated: 'Use #outerRadialRatio:'
		transformWith:
		'`@rcvr outerRadius: `@arg' -> '`@rcvr outerRadialRatio: `@arg'.
	self outerRadialRatio: anObject
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> startAngle [

	^ startAngle ifNil: [ startAngle := 0 ]
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> startAngle: anAngleInDgrees [

	startAngle := anAngleInDgrees
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> startAngleOffset [

	^ startAngleOffset ifNil: [ startAngleOffset := 0 ] 
]

{ #category : #'t - annulus sector layout state' }
TToAnnulusSectorLayoutState >> startAngleOffset: anAngleInDegrees [

	startAngleOffset := anAngleInDegrees
]
