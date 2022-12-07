Class {
	#name : #ToToggleButtonDresser,
	#superclass : #ToDresser,
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
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation: (BlTransformAnimation new
						   duration: self defaultAnimationDuration;
						   transformDo: [ :b | 
							   b translateBy: (self slideLength @ 0) negated ]) ];
		  whenEnterDo: [ :ann | 
			  ann widget icon background: (Color lightGray alpha: 0.5).
			  ann widget iconImage background: Color black ];
		  yourself
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultIconImage [

	^ BlElement new
		  size: 10 @ 10;
		  background: Color black;
		  margin: (BlInsets all: 3);
		  geometry: BlEllipseGeometry new;
		  constraintsDo: [ :c | c linear vertical alignCenter ];
		  yourself
]

{ #category : #initialization }
ToToggleButtonDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenExitDo: [ :ann | 
			  ann widget iconImage addAnimation: (BlTransformAnimation new
						   duration: self defaultAnimationDuration;
						   transformDo: [ :b | b translateBy: self slideLength @ 0 ]) ];
		  whenEnterDo: [ :ann | 
			  ann widget icon background: (Color veryLightGray alpha: 0.1).
			  ann widget iconImage background: Color veryLightGray ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToToggleButtonDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement icon layout: BlLinearLayout horizontal.
	anElement icon constraintsDo: [ :c | 
		c horizontal exact: 24.
		c vertical fitContent ].
	anElement icon geometry: (BlRoundedRectangleGeometry  cornerRadius: 6).
	anElement icon background: (Color veryLightGray alpha: 0.5).
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

	^ 8
]
