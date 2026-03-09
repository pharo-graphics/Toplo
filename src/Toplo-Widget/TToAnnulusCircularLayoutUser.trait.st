Trait {
	#name : #TToAnnulusCircularLayoutUser,
	#instVars : [
		'layoutRadius'
	],
	#category : #'Toplo-Widget-Circular'
}

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> defaultLayoutRadius [

	^ 150
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> layoutRadius [
 
	^ layoutRadius ifNil: [ layoutRadius := self defaultLayoutRadius ]
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> layoutRadius: aNumber [

	layoutRadius := aNumber
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> radius [

	self deprecated: 'Use #layoutRadius' transformWith: '`@rcvr radius'->'`@rcvr layoutRadius'.
	^ self layoutRadius
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> radius: aNumber [

	self
		deprecated: 'Use #layoutRadius:'
		transformWith:
		'`@rcvr radius: `@arg' -> '`@rcvr layoutRadius: `@arg'.

	self layoutRadius: aNumber
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> startAngleOffset [

	^ self stateHolder startAngleOffset
]

{ #category : #'t - annulus circular layout user' }
TToAnnulusCircularLayoutUser >> startAngleOffset: anAngleInDgrees [

	self stateHolder startAngleOffset: anAngleInDgrees
]
