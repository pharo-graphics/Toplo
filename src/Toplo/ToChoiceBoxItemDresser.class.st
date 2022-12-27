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
ToChoiceBoxItemDresser >> defaultCheckedIconImage [

	^ Smalltalk ui icons iconNamed: 'smallOk'
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  ann widget element: (ToImage inner: self defaultCheckedIconImage) ];
		  yourself
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 14 @ 14;
		  yourself
]

{ #category : #initialization }
ToChoiceBoxItemDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget element: (ToImage inner: self defaultUncheckedIconImage) ]
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
