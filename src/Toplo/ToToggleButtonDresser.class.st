Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToToggleButtonDresser >> defaultAnimationDuration [

	^ 200 milliSeconds
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  ann widget icon background: (Color black alpha: 0.4).
			  ann widget iconImage background: Color black ];
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation:
					  (BlParallelAnimation withAll: { 
								   (BlTransformAnimation new
									    duration: self defaultAnimationDuration;
									    transformDo: [ :b | 
										    b translateBy: (self slideLength @ 0) negated ]).
								   (BlColorTransition new
									    duration: self defaultAnimationDuration;
									    from: Color black;
									    to: Color veryLightGray;
									    onStepDo: [ :aColor :anElement | 
										    ann widget icon background: (aColor alpha: 0.4).
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
			  ann widget icon background: (Color veryLightGray alpha: 0.4).
			  ann widget iconImage background: Color veryLightGray ];
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation:
					  (BlParallelAnimation withAll: { 
								   (BlTransformAnimation new
									    duration: self defaultAnimationDuration;
									    transformDo: [ :b | b translateBy: self slideLength @ 0 ]).
								   (BlColorTransition new
									    duration: self defaultAnimationDuration;
									    from: Color veryLightGray;
									    to: Color black;
									    onStepDo: [ :aColor :anElement | 
										    ann widget icon background: (aColor alpha: 0.4).
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

	^ 10
]
