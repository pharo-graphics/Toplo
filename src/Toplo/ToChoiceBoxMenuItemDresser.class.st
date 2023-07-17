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

	^ ToElementStateDep new
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

	^ ToElementStateDep new
		  name: #unchecked;
		  whenEnterDo: [ :ann | 
			  ann widget icon: (ToImage inner: self defaultUncheckedIconImage) ]
]

{ #category : #'events handling' }
ToChoiceBoxMenuItemDresser >> leftMouseUpEvent: anEvent in: anElement [

	super leftMouseUpEvent: anEvent in: anElement.
	anElement parentMenuWindow close
]

{ #category : #deprecated }
ToChoiceBoxMenuItemDresser >> leftUp: anElement event: anEvent [

	self
		deprecated: 'Please use leftMouseUpEvent:in: instead.'
		transformWith:
			'`@receiver leftUp: `@anElement event: `@anEvent'
				-> '`@receiver leftMouseUpEvent: `@anEvent in: `@anElement'.
	super leftUp: anElement event: anEvent.
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


]
