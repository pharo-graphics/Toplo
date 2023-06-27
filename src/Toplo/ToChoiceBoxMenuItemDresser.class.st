Class {
	#name : #ToChoiceBoxMenuItemDresser,
	#superclass : #ToGeneralButtonDresser,
	#category : #'Toplo-Widget-ChoiceBox'
}

{ #category : #initialization }
ToChoiceBoxMenuItemDresser >> defaultCheckedIconImage [

	^ Smalltalk ui icons iconNamed: 'smallOk'
]

{ #category : #initialization }
ToChoiceBoxMenuItemDresser >> defaultCheckedState [

	^ ToWidgetState new
		  name: #checked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: (ToImage inner: self defaultCheckedIconImage) ];
		  yourself
]

{ #category : #initialization }
ToChoiceBoxMenuItemDresser >> defaultUncheckedIconImage [

	^ BlElement new
		  size: 14 @ 14;
		  yourself
]

{ #category : #initialization }
ToChoiceBoxMenuItemDresser >> defaultUncheckedState [

	^ ToWidgetState new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: (ToImage inner: self defaultUncheckedIconImage) ]
]

{ #category : #'events handling' }
ToChoiceBoxMenuItemDresser >> leftClicked: anElement [

	super leftClicked: anElement.
	anElement parentMenuWindow close
]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxMenuItemDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement setUpStatesWith: { 
			self defaultUncheckedState.
			self defaultCheckedState }
]

{ #category : #'api - install/uninstall  hook' }
ToChoiceBoxMenuItemDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement unsubscribe: self

]
