Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'icon'
	],
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
			  | anim |
			  anim := BlParallelAnimation withAll: { 
						          (BlTransformAnimation new
							           duration: self defaultAnimationDuration;
							           transformDo: [ :b | 
								           b translateBy: (self slideLength @ 0) negated ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self checkedStateIconBackground;
							           to: self uncheckedStateIconBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget element background: aColor ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self checkedStateIconImageBackground;
							           to: self uncheckedStateIconImageBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget element innerImage background: aColor ]) }.
			  anim onFinishedDo: [ 
				  ann widget element innerImage transformDo: [ :aTransform | 
					  aTransform translateBy: 0 @ 0 ] ].
			  ann widget element innerImage addAnimation: anim ]
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultIconImage [

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
ToToggleButtonDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget element background: self uncheckedStateIconBackground.
			  ann widget element innerImage background:
					  self uncheckedStateIconImageBackground ];
		  whenExitDo: [ :ann | 
			  | anim |
			  anim := BlParallelAnimation withAll: { 
						          (BlTransformAnimation new
							           duration: self defaultAnimationDuration;
							           transformDo: [ :b | 
								           b translateBy: self slideLength @ 0 ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self uncheckedStateIconBackground;
							           to: self checkedStateIconBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget element background: aColor ]).
						          (BlColorTransition new
							           duration: self defaultAnimationDuration;
							           from: self uncheckedStateIconImageBackground;
							           to: self checkedStateIconImageBackground;
							           onStepDo: [ :aColor :anElement | 
								           ann widget element innerImage background: aColor ]) }.
			  anim onFinishedDo: [ 
				  ann widget element innerImage transformDo: [ :aTransform | 
					  aTransform translateBy: self slideLength @ 0 ] ].
			  ann widget element innerImage addAnimation: anim ]
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement element: self defaultIconImage.
	anElement element layout: BlLinearLayout horizontal.
	anElement element constraintsDo: [ :c | 
		c horizontal exact: 30.
		c vertical fitContent. ].
	anElement element geometry: (BlRoundedRectangleGeometry  cornerRadius: 12).
	
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

	^ 13
]

{ #category : #initialization }
ToToggleButtonDresser >> uncheckedStateIconBackground [

	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToToggleButtonDresser >> uncheckedStateIconImageBackground [

	^ Color veryLightGray
]
