Class {
	#name : #ToPaneNodeExample,
	#superclass : #ToPane,
	#category : 'Toplo-Examples'
}

{ #category : #'t - list node - initialization' }
ToPaneNodeExample >> defaultEventHandler [

	^ ToPaneNodeExampleEventHandler new
]

{ #category : #initialization }
ToPaneNodeExample >> initialize [

	| p1 p2 p3 |
	super initialize.
	self beHorizontal.	
	self
		clipChildren: false;
		outskirts: BlOutskirts outside;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		margin: (BlInsets all: 6);
		padding: (BlInsets all: 6).
		
	p1 := ToPane vertical background: Color blue; width: 50; yourself.
	p2 := ToPane vertical background: (Color blue alpha: 0.6); width: 100; yourself.
	p3 := ToPane vertical background: (Color blue alpha: 0.3); hMatchParent; yourself.
	self addChildren: { p1. p2. p3 }.
	self height: 60.
	self hMatchParent.
	self addEventHandler: self defaultEventHandler 
	
	
]
