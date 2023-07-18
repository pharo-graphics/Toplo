Class {
	#name : #ToCheckBoxDresserDep,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'checkedIcon',
		'indeterminateIcon',
		'uncheckedIcon'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #accessing }
ToCheckBoxDresserDep >> checkIndeterminateIn: anElement [

	anElement hasIndeterminateState
		ifTrue: [ self withIndeterminateIn: anElement ]
		ifFalse: [ self withoutIndeterminateIn: anElement ].

]

{ #category : #'events handling' }
ToCheckBoxDresserDep >> clicked: anElement [

	anElement checked: anElement checked not.
	super clicked: anElement
]

{ #category : #initialization }
ToCheckBoxDresserDep >> defaultAnimationDuration [

	^ 300 milliSeconds
]

{ #category : #initialization }
ToCheckBoxDresserDep >> defaultCheckedIconImage [

	^ checkedIcon ifNil: [
		  checkedIcon := ToImage inner: (BlElement new
				                  size: 12 @ 12;
				                  border: (BlBorder paint: Color lightGray width: 1);
				                  margin: (BlInsets all: 2);
				                  background: theme button hoveredBorderColor;
				                  yourself) ]
]

{ #category : #initialization }
ToCheckBoxDresserDep >> defaultCheckedState [

	^ ToElementStateDep new
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
ToCheckBoxDresserDep >> defaultIndeterminateIconImage [

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
ToCheckBoxDresserDep >> defaultIndeterminateState [

	^ ToElementStateDep new
		  name: #indeterminate;
		  whenEnterDo: [ :ann | 
			  ann widget icon: self defaultIndeterminateIconImage ];
		  yourself
]

{ #category : #initialization }
ToCheckBoxDresserDep >> defaultUncheckedIconImage [

	^ uncheckedIcon ifNil: [ 
		  uncheckedIcon := ToImage inner: (BlElement new
				                    size: 12 @ 12;
				                    margin: (BlInsets all: 2);
				                    border: (BlBorder paint: Color gray width: 1);
				                    background: (Color gray alpha: 0.2);
				                    yourself) ]
]

{ #category : #initialization }
ToCheckBoxDresserDep >> defaultUncheckedState [

	^ ToElementStateDep new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: self defaultUncheckedIconImage ]
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresserDep >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresserDep >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #accessing }
ToCheckBoxDresserDep >> withIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultIndeterminateState.
			self defaultCheckedState.
			self defaultUncheckedState }
]

{ #category : #accessing }
ToCheckBoxDresserDep >> withoutIndeterminateIn: anElement [

	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]
