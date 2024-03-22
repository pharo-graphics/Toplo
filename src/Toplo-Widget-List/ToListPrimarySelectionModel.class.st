Class {
	#name : #ToListPrimarySelectionModel,
	#superclass : #ToListStandardSelectionModel,
	#instVars : [
		'listElement'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToListPrimarySelectionModel >> copySelectionFrom: anotherSelectionModel [

	super copySelectionFrom: anotherSelectionModel.
	self unselectableSelectionModel  copySelectionFrom: anotherSelectionModel unselectableSelectionModel.
	self disabledSelectionModel  copySelectionFrom: anotherSelectionModel disabledSelectionModel.
	self hiddenSelectionModel  copySelectionFrom: anotherSelectionModel hiddenSelectionModel
]

{ #category : #updating }
ToListPrimarySelectionModel >> disableIndex: anIndex [

	self disabledSelecter selectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> enableAll [

	self disabledSelecter deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> enableIndex: anIndex [

	self disabledSelecter deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> hideIndex: anIndex [

	self hiddenSelecter selectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> hideOnlyIndexes: aCollection [

	self hiddenSelecter selectOnlyIndexes: aCollection
]

{ #category : #'private - initialization' }
ToListPrimarySelectionModel >> installSelecterForEventClass: anEventClass in: aListElement [

	^ self
		  installSelecterForEventClass: anEventClass
		  in: aListElement
		  withSelectionModel: aListElement newSelectionModel
]

{ #category : #'private - initialization' }
ToListPrimarySelectionModel >> installSelecterForEventClass: anEventClass in: aListElement withSelectionModel: aSelectionModel [

	| newSelecter operator |
	operator := ToAdditionalSelectionModelOperator eventClass:
		            anEventClass.
	aSelectionModel onInstalledIn: aListElement.
	newSelecter := ToMultiSelectionModelSelecter new.
	operator selectionModel: aSelectionModel.
	operator onInstalledIn: aListElement.
	newSelecter operator: operator.
	newSelecter onInstalledIn: aListElement.

	^ newSelecter
]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onInstalledIn: aListElement [

	super onInstalledIn: aListElement.
	listElement := aListElement.
	unselectableSelecter := self installSelecterForEventClass:
		                        ToListUnselectableSelectionChangedEvent in: aListElement.
	disabledSelecter := self installSelecterForEventClass:
		                    ToListDisabledSelectionChangedEvent in: aListElement.
	hiddenSelecter := self installSelecterForEventClass:
		                  ToListHiddenSelectionChangedEvent in: aListElement.


]

{ #category : #'api - hooks' }
ToListPrimarySelectionModel >> onUninstalledIn: aListElement [

	unselectableSelecter onInstalledIn: aListElement.
	disabledSelecter onInstalledIn: aListElement.
	hiddenSelecter onInstalledIn: aListElement.
	super onUninstalledIn: aListElement
]

{ #category : #copying }
ToListPrimarySelectionModel >> postCopy [

	super postCopy.

	unselectableSelecter := self
		                        installSelecterForEventClass:
		                        ToListUnselectableSelectionChangedEvent
		                        in: listElement
		                        withSelectionModel:
		                        self unselectableSelectionModel copy.
	disabledSelecter := self
		                    installSelecterForEventClass:
		                    ToListDisabledSelectionChangedEvent
		                    in: listElement
		                    withSelectionModel:
		                    self disabledSelectionModel copy.
	hiddenSelecter := self
		                  installSelecterForEventClass:
		                  ToListHiddenSelectionChangedEvent
		                  in: listElement
		                  withSelectionModel: self hiddenSelectionModel copy
]

{ #category : #updating }
ToListPrimarySelectionModel >> selectableAll [

	self unselectableSelecter deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> selectableIndex: anIndex [

	self unselectableSelecter deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> transferIndex: anIndex from: anotherPrimarySelectionModel as: targetIndex [

	(anotherPrimarySelectionModel containsIndex: anIndex)
		ifTrue: [ self selectIndex: targetIndex ]
		ifFalse: [ self deselectIndex: targetIndex ].
	(anotherPrimarySelectionModel disabledSelectionModel containsIndex: anIndex)
		ifTrue: [ self disabledSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self disabledSelectionModel deselectIndex: targetIndex ].
	(anotherPrimarySelectionModel unselectableSelectionModel containsIndex: anIndex)
		ifTrue: [ self unselectableSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self unselectableSelectionModel deselectIndex: targetIndex ].
	(anotherPrimarySelectionModel hiddenSelectionModel containsIndex: anIndex)
		ifTrue: [ self hiddenSelectionModel selectIndex: targetIndex ]
		ifFalse: [ self hiddenSelectionModel deselectIndex: targetIndex ]
]

{ #category : #updating }
ToListPrimarySelectionModel >> unhideAll [

	self hiddenSelecter deselectAll
]

{ #category : #updating }
ToListPrimarySelectionModel >> unhideIndex: anIndex [

	self hiddenSelecter deselectIndex: anIndex
]

{ #category : #updating }
ToListPrimarySelectionModel >> unselectableIndex: anIndex [

	self unselectableSelecter selectIndex: anIndex
]
