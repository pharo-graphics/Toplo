Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToButtonDresser,
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon'
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
			  ann widget element: self defaultCheckedIconImage.
			  ann widget isAttachedToSceneGraph ifTrue: [ 
					  | op |
					  op := ann widget element innerImage opacity.
					  ann widget element innerImage opacity: 0.1.
					  ann widget element innerImage addAnimation: (BlOpacityAnimation new
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
		  whenEnterDo: [ :ann | ann widget element: self defaultIndeterminateIconImage ];
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
			  ann widget element: self defaultUncheckedIconImage ]
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
