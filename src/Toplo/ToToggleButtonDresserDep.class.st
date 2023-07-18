Class {
	#name : #ToToggleButtonDresserDep,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'icon'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToToggleButtonDresserDep >> checkedStateIconBackground [

	^ Color black
]

{ #category : #initialization }
ToToggleButtonDresserDep >> checkedStateIconImageBackground [

	^ Color white
]

{ #category : #initialization }
ToToggleButtonDresserDep >> defaultAnimationDuration [

	^ 200 milliSeconds
]

{ #category : #initialization }
ToToggleButtonDresserDep >> defaultCheckedState [

	^ ToElementStateDep new
		  name: #checked;
		  whenExitDo: [ :ann | 
			  | anim |
			  anim := BlParallelAnimation withAll: { 
						          (BlTransformAnimation new
							           duration: self defaultAnimationDuration;
							           transformDo: [ :b | b translateBy: (self slideLength @ 0) negated ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self checkedStateIconBackground;
							           to: self uncheckedStateIconBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget icon background: aColor ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self checkedStateIconImageBackground;
							           to: self uncheckedStateIconImageBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget icon innerImage background: aColor ]) }.
			  anim onFinishedDo: [ 
				  ann widget icon innerImage transformDo: [ :aTransform | 
					  aTransform translateBy: 0 @ 0 ] ].
			  ann widget icon innerImage addAnimation: anim ]
]

{ #category : #initialization }
ToToggleButtonDresserDep >> defaultIconImage [

	^ icon ifNil: [ 
		  icon := ToImage inner: (ToElement new
				           background: Color black;
				           margin: (BlInsets all: 2);
				           geometry: BlEllipseGeometry new;
				           vExact: 14;
				           hExact: 14;
				           yourself) ]
]

{ #category : #initialization }
ToToggleButtonDresserDep >> defaultUncheckedState [

	^ ToElementStateDep new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon background: self uncheckedStateIconBackground.
			  ann widget icon innerImage background: self uncheckedStateIconImageBackground ];
		  whenExitDo: [ :ann | 
			  | anim |
			  anim := BlParallelAnimation withAll: { 
						          (BlTransformAnimation new
							           duration: self defaultAnimationDuration;
							           transformDo: [ :b | b translateBy: self slideLength @ 0 ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self uncheckedStateIconBackground;
							           to: self checkedStateIconBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget icon background: aColor ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self uncheckedStateIconImageBackground;
							           to: self checkedStateIconImageBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget icon innerImage background: aColor ]) }.
			  anim onFinishedDo: [ 
				  ann widget icon innerImage transformDo: [ :aTransform | 
					  aTransform translateBy: self slideLength @ 0 ] ].
			  ann widget icon innerImage addAnimation: anim ]
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresserDep >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement icon: self defaultIconImage.
	anElement icon layout: BlLinearLayout horizontal.
	anElement icon constraintsDo: [ :c | 
		c horizontal exact: 30.
		c vertical fitContent. ].
	anElement icon geometry: (BlRoundedRectangleGeometry  cornerRadius: 12).
	
	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresserDep >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #private }
ToToggleButtonDresserDep >> slideLength [

	^ 13
]

{ #category : #initialization }
ToToggleButtonDresserDep >> uncheckedStateIconBackground [

	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToToggleButtonDresserDep >> uncheckedStateIconImageBackground [

	^ Color veryLightGray
]
