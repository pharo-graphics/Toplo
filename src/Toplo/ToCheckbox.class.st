Class {
	#name : #ToCheckbox,
	#superclass : #ToButton,
	#instVars : [
		'#threeSteps => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
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
ToCheckbox >> defaultStates [

	^ threeSteps ifTrue: [ self defaultThreeStates  ] ifFalse: [ self defaultTwoStates  ]
]

{ #category : #initialization }
ToCheckbox >> defaultThreeStates [

	^ { 
		  (ToButtonState new
			   name: #indeterminate;
			   buttonStencil: [ :button | 
				   button iconImage: self inderterminateStateIconImage ];
			   yourself).
		  (ToButtonState new
			   name: #checked;
			   buttonStencil: [ :button | 
				   button iconImage: self checkedIconImage ];
			   yourself).
		  (ToButtonState new
			   name: #unchecked;
			   buttonStencil: [ :button | 
				   button iconImage: self uncheckedIconImage ];
			   yourself) }
]

{ #category : #initialization }
ToCheckbox >> defaultTwoStates [

	^ { 
		  (ToButtonState new
			   name: #unchecked;
			   buttonStencil: [ :button | 
				   button iconImage: self uncheckedIconImage ];
			   yourself).
		  (ToButtonState new
			   name: #checked;
			   buttonStencil: [ :button | 
				   button iconImage: self checkedIconImage ];
			   yourself) }
]

{ #category : #initialization }
ToCheckbox >> inderterminateStateIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: ((BlLinearGradientPaint direction: 1 @ 1)
				         start: 25 @ 0;
				         stops: { 
						         (0 -> Color gray).
						         (0.45 -> (Color gray alpha: 0.4)).
						         (0.50 -> (Color gray alpha: 0.1)).
						         (0.50 -> (Color gray alpha: 0.0)).
						         (1 -> Color transparent) });
		  yourself ).
]

{ #category : #initialization }
ToCheckbox >> initialize [ 
	super initialize.
	self whenThreeStepsChangedDo: [ self states: self defaultStates ].
	threeSteps := false
	
]

{ #category : #testing }
ToCheckbox >> isChecked [

	^ state notNil and: [ state name = #checked ]
]

{ #category : #testing }
ToCheckbox >> isIndeterminate [

	^ state notNil and: [ state name = #indeterminate ]
]

{ #category : #testing }
ToCheckbox >> isUnchecked [

	^ state notNil and: [ state name = #unchecked ]
]

{ #category : #initialization }
ToCheckbox >> uncheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself ).
]

{ #category : #'api - change hook' }
ToCheckbox >> whenCheckedDo: aBlock [

	self
		whenStateChangedDo: [ :s | s name = #checked ifTrue: [ aBlock value ] ]
]

{ #category : #'api - change hook' }
ToCheckbox >> whenIndeterminateDo: aBlock [

	self
		whenStateChangedDo: [ :s | s name = #indeterminate ifTrue: [ aBlock value ] ]
]

{ #category : #'api - change hook' }
ToCheckbox >> whenThreeStepsChangedDo: aBlock [
	"Inform when the threeSteps boolean has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new  value
	 - old  value"

	self property: #threeSteps whenChangedDo: aBlock
]

{ #category : #'api - change hook' }
ToCheckbox >> whenUncheckedDo: aBlock [

	self
		whenStateChangedDo: [ :s | s name = #unchecked ifTrue: [ aBlock value ] ]
]

{ #category : #initialization }
ToCheckbox >> withTreeStates [

	threeSteps := true
]

{ #category : #initialization }
ToCheckbox >> withTwoStates [

	threeSteps := false
]
