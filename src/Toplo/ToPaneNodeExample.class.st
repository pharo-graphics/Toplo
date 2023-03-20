Class {
	#name : #ToPaneNodeExample,
	#superclass : #ToPane,
	#category : #'Toplo-Examples'
}

{ #category : #'t - initialization dresser' }
ToPaneNodeExample >> defaultDresser [ 

	^ ToNodeWithHoverButtonDresserExample new
]

{ #category : #initialization }
ToPaneNodeExample >> initialize [

	| p1 p2 p3 |
	super initialize.
	self initializeDresser.
	self beHorizontal.
	p1 := ToPane new beVertical; background: Color blue; width: 50.
	p2 := ToPane new beVertical; background: (Color blue alpha: 0.6); width: 100.
	p3 := ToPane new beVertical; background: (Color blue alpha: 0.3); width: 50.
	self addChildren: { p1. p2. p3 }.
	self height: 100.
	
	
]
