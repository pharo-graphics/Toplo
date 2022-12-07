Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialization }
ToCheckBoxDresser >> defaultCheckedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color lightGray width: 2);
		  background: theme button hoveredBorderColor;
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  | op |
			  ann widget iconImage: self defaultCheckedIconImage.
			  op := ann widget iconImage opacity.
			  ann widget iconImage opacity: 0.
			  ann widget iconImage addAnimation: (BlOpacityAnimation new
						   duration: self defaultAnimationDuration;
						   opacity: op;
						   yourself) ];
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultIndeterminateIconImage [

	| bar im |
	bar := BlElement new
		       size: 10 @ 2;
		       border: (BlBorder paint: Color black width: 1);
		       background: Color gray.
	bar constraintsDo: [ :c | 
		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	im := BlElement new
		      size: 16 @ 16;
		      border: (BlBorder paint: Color lightGray width: 1);
		      yourself.
	im layout: BlFrameLayout new.
	im addChild: bar.
	^ im
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultIndeterminateState [

	^ ToWidgetState new
		  name: #indeterminate;
		  whenEnterDo: [ :ann | ann widget iconImage: self defaultIndeterminateIconImage ];
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  | prevIm op |
			  prevIm := ann widget iconImage.
			  op := prevIm opacity.
			  ann widget iconImage addAnimation: (BlOpacityAnimation new
						   duration: self defaultAnimationDuration;
						   opacity: 0;
						   onFinishedDo: [ 
							   ann widget iconImage: self defaultUncheckedIconImage.
							   prevIm opacity: op ];
						   yourself) ]
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToCheckBoxDresser >> withIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultIndeterminateState.
			self defaultCheckedState.
			self defaultUncheckedState }
]

{ #category : #accessing }
ToCheckBoxDresser >> withoutIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]
