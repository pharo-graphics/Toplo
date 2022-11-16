Class {
	#name : #ToCheckboxDresser,
	#superclass : #ToBasicButtonDresser,
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - checked change hook' }
ToCheckboxDresser >> actualIconImageIn: aCheckbox [

	^ aCheckbox
		  ifChecked: [ self checkedIconImage]
		  unchecked: [ self uncheckedIconImage]
		  else: [ self inderterminateStateIconImage ]
]

{ #category : #'api - hooks' }
ToCheckboxDresser >> checkedChangedIn: aCheckbox [

	aCheckbox  icon innerImage: (self actualIconImageIn: aCheckbox)
]

{ #category : #initialization }
ToCheckboxDresser >> checkedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: Color gray;
		  yourself
]

{ #category : #initialization }
ToCheckboxDresser >> inderterminateStateIconImage [

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

{ #category : #'api - hooks' }
ToCheckboxDresser >> onInstalledIn: aCheckbox [

	super onInstalledIn: aCheckbox.
	aCheckbox whenCheckedChangedDo: [ self checkedChangedIn: aCheckbox ].
	self checkedChangedIn: aCheckbox

]

{ #category : #initialization }
ToCheckboxDresser >> uncheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself ).
]
