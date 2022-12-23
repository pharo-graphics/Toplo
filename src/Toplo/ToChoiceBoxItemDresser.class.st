Class {
	#name : #ToChoiceBoxItemDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #'events handling' }
ToChoiceBoxItemDresser >> clicked: anElement [

	super clicked: anElement.
	anElement parentMenuWindow close
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultAnimationDuration [

	^ 300 milliSeconds
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultCheckedIconImage [

	^ BlElement new
		  size: 12 @ 12;
		  border: (BlBorder paint: Color lightGray width: 1);
		  margin: (BlInsets all: 2);
		  background: theme button hoveredBorderColor;
		  yourself
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  ann widget iconImage: self defaultCheckedIconImage.
			  ann widget isAttachedToSceneGraph ifTrue: [ 
					  | op |
					  op := ann widget iconImage opacity.
					  ann widget iconImage opacity: 0.1.
					  ann widget iconImage addAnimation: (BlOpacityAnimation new
								   duration: (ann state counter isZero
										    ifTrue: [ 0 milliSecond ]
										    ifFalse: [ self defaultAnimationDuration ]);
								   opacity: op;
								   yourself) ] ];
		  yourself
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 12 @ 12;
		  margin: (BlInsets all: 2);
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget iconImage: self defaultUncheckedIconImage ]
]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxItemDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement unsubscribe: self

]
