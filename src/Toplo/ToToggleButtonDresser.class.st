Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToToggleButtonDresser >> checkedStateIconBackground [

	^ Color black
]

{ #category : #initialization }
ToToggleButtonDresser >> checkedStateIconImageBackground [

	^ Color white
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultAnimationDuration [

	^ 200 milliSeconds
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation:
					  (BlParallelAnimation withAll: { 
								   (BlTransformAnimation new
									    duration: self defaultAnimationDuration;
									    transformDo: [ :b | 
										    b translateBy: (self slideLength @ 0) negated ]).
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
										    ann widget iconImage background: aColor ]) }) ]
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultIconImage [

	^ ToElement new
		  background: Color black;
		  margin: (BlInsets all: 2);
		  geometry: BlEllipseGeometry new;
		  vExact: 12;
		  hExact: 12;
		  yourself
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon background: self uncheckedStateIconBackground.
			  ann widget iconImage background:
					  self uncheckedStateIconImageBackground ];
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation:
					  (BlParallelAnimation withAll: { 
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
										    ann widget iconImage background: aColor ]) }) ]
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement icon layout: BlLinearLayout horizontal.
	anElement icon constraintsDo: [ :c | 
		c horizontal exact: 24.
		c vertical fitContent. ].
	anElement icon geometry: (BlRoundedRectangleGeometry  cornerRadius: 6).
	anElement iconImage: self defaultIconImage.
	
	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #private }
ToToggleButtonDresser >> slideLength [

	^ 9
]

{ #category : #initialization }
ToToggleButtonDresser >> uncheckedStateIconBackground [

	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToToggleButtonDresser >> uncheckedStateIconImageBackground [

	^ Color veryLightGray
]
