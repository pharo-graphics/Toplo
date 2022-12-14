Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToCheckBoxDresser >> checkIndeterminateIn: anElement [

	anElement hasIndeterminateState
		ifTrue: [ self withIndeterminateIn: anElement ]
		ifFalse: [ self withoutIndeterminateIn: anElement ].

]

{ #category : #initialization }
ToCheckBoxDresser >> defaultAnimationDuration [

	^ 200 milliSeconds
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultCheckedIconImage [

	^ BlElement new
		  size: 12 @ 12;
		  border: (BlBorder paint: Color lightGray width: 1);
		  margin: (BlInsets all: 2);
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
			  ann widget iconImage opacity: 0.1.
			  ann widget iconImage addAnimation: (BlOpacityAnimation new
						   duration: (ann state counter isZero ifTrue: [0 milliSecond] ifFalse: [self defaultAnimationDuration]);
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
		      size: 12 @ 12;
				margin: (BlInsets all: 2);
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
		  size: 12 @ 12;
		  margin: (BlInsets all: 2);
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
						   duration: (ann state counter isZero ifTrue: [0 milliSecond] ifFalse: [self defaultAnimationDuration]);
						   opacity: 0.1;
						   onFinishedDo: [ 
							   ann widget iconImage: self defaultUncheckedIconImage.
							   prevIm opacity: op ];
						   yourself) ]
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self checkIndeterminateIn: anElement.
	anElement
		whenAnnouncement: ToStatesDefinitionChangedAnnouncement
		do: [ self checkIndeterminateIn: anElement ]
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement unsubscribe: self

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
