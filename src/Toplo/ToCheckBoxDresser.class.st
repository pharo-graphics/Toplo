Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon',
		'statesChangedHandler'
	],
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

	^ 300 milliSeconds
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultCheckedIconImage [

	^ checkedIcon ifNil: [ 
		  checkedIcon := ToImage inner: (BlElement new
				                  size: 12 @ 12;
				                  border: (BlBorder paint: Color lightGray width: 1);
				                  margin: (BlInsets all: 2);
				                  background: theme button hoveredBorderColor;
				                  yourself) ]
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: self defaultCheckedIconImage.
			  ann widget isAttachedToSceneGraph ifTrue: [ 
					  | op |
					  op := ann widget icon innerImage opacity.
					  ann widget icon innerImage opacity: 0.1.
					  ann widget icon innerImage addAnimation:
							  (BlOpacityAnimation new
								   duration: (ann state counter isZero
										    ifTrue: [ 0 milliSecond ]
										    ifFalse: [ self defaultAnimationDuration ]);
								   opacity: op;
								   yourself) ] ];
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultIndeterminateIconImage [

	| bar im |
	indeterminateIcon ifNotNil: [ ^ indeterminateIcon ].

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
	indeterminateIcon := ToImage inner: im.
	^ indeterminateIcon
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultIndeterminateState [

	^ ToWidgetState new
		  name: #indeterminate;
		  whenEnterDo: [ :ann | 
			  ann widget icon: self defaultIndeterminateIconImage ];
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultUncheckedIconImage [

	^ uncheckedIcon ifNil: [ 
		  uncheckedIcon := ToImage inner: (BlElement new
				                    size: 12 @ 12;
				                    margin: (BlInsets all: 2);
				                    border: (BlBorder paint: Color gray width: 1);
				                    background: (Color gray alpha: 0.2);
				                    yourself) ]
]

{ #category : #initialization }
ToCheckBoxDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: self defaultUncheckedIconImage ]
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self checkIndeterminateIn: anElement.

	statesChangedHandler := BlEventHandler 
		on: ToStatesDefinitionChangedEvent 
		do: [ self checkIndeterminateIn: anElement ].
		
	anElement addEventHandler: statesChangedHandler
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onUninstalledIn: anElement [

	anElement removeEventHandler: statesChangedHandler.
	super onUninstalledIn: anElement
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
