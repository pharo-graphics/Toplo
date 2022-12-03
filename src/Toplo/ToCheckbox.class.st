Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#traits : 'TToCheckableWidget',
	#classTraits : 'TToCheckableWidget classTrait',
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToCheckbox >> checkedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: Color gray;
		  yourself
]

{ #category : #initialization }
ToCheckbox >> inderterminateIconImage [

	| bar im |
	bar := BlElement new
		       size: 10 @ 3;
		       border: (BlBorder paint: Color gray width: 1);
		       background: Color gray.
	bar constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	im := BlElement new
		      size: 16 @ 16;
		      border: (BlBorder paint: Color gray width: 1);
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: bar.
	^ im
]

{ #category : #initialization }
ToCheckbox >> initialize [ 
	super initialize.
	self initializeAsCheckable
]

{ #category : #initialization }
ToCheckbox >> uncheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself ).
]
