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
	p1 := ToPane vertical background: Color blue; width: 50; yourself.
	p2 := ToPane vertical background: (Color blue alpha: 0.6); width: 100; yourself.
	p3 := ToPane vertical background: (Color blue alpha: 0.3); hMatchParent; yourself.
	self addChildren: { p1. p2. p3 }.
	self height: 100.
	
	
]
