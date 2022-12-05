Class {
	#name : #ToToggleButton,
	#superclass : #ToGeneralButton,
	#instVars : [
		'icon'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #factory }
ToToggleButton class >> horizontal [

	^ ToHorizontalToggleButton new
]

{ #category : #factory }
ToToggleButton class >> vertical [

	^ ToVerticalToggleButton new
]

{ #category : #private }
ToToggleButton >> animationTranslation [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToToggleButton >> checkedIconImage [

	| im |
	im := BlElement new
		      size: 24 @ 24;
		      background: Color black;
		      margin: (BlInsets all: 3);
		      geometry: BlEllipseGeometry new;
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: (BlTextElement new
			 text: ('ON' asRopedText
					  fontSize: 13;
					  bold;
					  foreground: Color white);
			 constraintsDo: [ :c | 
				 c frame vertical alignCenter.
				 c frame horizontal alignCenter ];
			 yourself).
	^ im
]

{ #category : #'t - initialization checkable' }
ToToggleButton >> checkedStateName [

	^ #checked
]

{ #category : #'t - initialization dresser' }
ToToggleButton >> defaultDresser [

	^ ToButtonDefaultDresser new
]

{ #category : #initialization }
ToToggleButton >> defaultStates [

	^ { 
		  (ToWidgetState new
			   name: self uncheckedStateName;
			   whenExitDo: [ :ann | 
				   ann widget icon addAnimation: (BlTransformAnimation new
							    duration: 200 milliSeconds;
							    transformDo: [ :b | b translateBy: self animationTranslation ]) ];
			   whenEnterDo: [ :ann | ann widget iconImage: self uncheckedIconImage ];
			   yourself).
		  (ToWidgetState new
			   name: self checkedStateName;
			   whenExitDo: [ :ann | 
				   ann widget icon addAnimation: (BlTransformAnimation new
							    duration: 200 milliSeconds;
							    transformDo: [ :b | b translateBy: self animationTranslation negated ]) ];
			   whenEnterDo: [ :ann | ann widget iconImage: self checkedIconImage ];
			   yourself) }
]

{ #category : #accessing }
ToToggleButton >> icon [

	^ icon
]

{ #category : #accessing }
ToToggleButton >> icon: anImage [

	icon = anImage ifTrue: [ ^self ].
	icon ifNotNil: [ self removeChild: icon ].
	self privateIcon: anImage.
	self addChild: icon
]

{ #category : #accessing }
ToToggleButton >> iconImage [

	^ icon innerImage
]

{ #category : #accessing }
ToToggleButton >> iconImage: anElement [

	icon innerImage: anElement
]

{ #category : #initialization }
ToToggleButton >> initialize [

	super initialize.
	self layout: BlLinearLayout new.
	self border: (BlBorder paint: Color black).
	self icon: ToImage new.
	self setUpStatesWith: self defaultStates.


]

{ #category : #private }
ToToggleButton >> privateIcon: anImage [

	icon := anImage.
	icon constraintsDo: [ :c | 
		c linear vertical alignCenter.
		c linear horizontal alignCenter ]
]

{ #category : #initialization }
ToToggleButton >> slideLength [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToToggleButton >> uncheckedIconImage [

	^ BlElement new
		  size: 24 @ 24;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  margin: (BlInsets all: 3);
		  geometry: BlEllipseGeometry new;
		  yourself
]

{ #category : #'t - initialization checkable' }
ToToggleButton >> uncheckedStateName [

	^ #unchecked
]
