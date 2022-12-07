Class {
	#name : #ToCheckBoxDresser,
	#superclass : #ToButtonDresser,
	#category : #'Toplo-Widget-Button'
}

{ #category : #initialize }
ToCheckBoxDresser >> defaultCheckedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color lightGray width: 2);
		  background: theme button hoveredBorderColor;
		  yourself
]

{ #category : #'t - initialization checkable' }
ToCheckBoxDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  | op |
			  ann widget iconImage: ann widget checkedIconImage.
			  op := ann widget iconImage opacity.
			  ann widget iconImage opacity: 0.
			  ann widget iconImage addAnimation: (BlOpacityAnimation new
						   duration: self defaultAnimationDuration;
						   opacity: op;
						   yourself) ];
		  yourself
]

{ #category : #initialize }
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

{ #category : #'t - initialization checkable' }
ToCheckBoxDresser >> defaultIndeterminateState [

	^ ToWidgetState new
		  name: #indeterminate;
		  whenEnterDo: [ :ann | ann widget iconImage: ann widget indeterminateIconImage ];
		  yourself
]

{ #category : #initialize }
ToCheckBoxDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 1);
		  background: (Color gray alpha: 0.2);
		  yourself
]

{ #category : #'t - initialization checkable' }
ToCheckBoxDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | ann widget iconImage: ann widget uncheckedIconImage ];
		  yourself
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement checkedIconImage: self defaultCheckedIconImage.
	anElement uncheckedIconImage: self defaultUncheckedIconImage.
	anElement indeterminateIconImage: self defaultIndeterminateIconImage.
	anElement checkedState: self defaultCheckedState.	
	anElement uncheckedState: self defaultUncheckedState.
	anElement indeterminateState: self defaultIndeterminateState
]

{ #category : #'api - install/uninstall  hook' }
ToCheckBoxDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]
