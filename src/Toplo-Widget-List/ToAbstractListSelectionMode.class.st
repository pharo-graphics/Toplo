Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'listElement',
		'listEventHandler',
		'selecter',
		'enabled',
		'elementBuilder',
		'option'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultElementBuilder [

	^ nil
]

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultOption [

	^ nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> elementBuilder: aSelectionElementBuilderValuable [

	self uninstallListEventHandler.
	elementBuilder := aSelectionElementBuilderValuable.
	elementBuilder ifNil: [ ^ self ].
	listElement ifNil: [ ^ self ].
	self installListEventHandler
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enable [

	self enabled: true
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled [

	^ enabled
]

{ #category : #accessing }
ToAbstractListSelectionMode >> enabled: aBoolean [
 
	enabled = aBoolean ifTrue: [ ^ self ].
	enabled := aBoolean.
	selecter ifNil: [ ^ self ].
	selecter enabled: aBoolean
]

{ #category : #initialization }
ToAbstractListSelectionMode >> initialize [

	super initialize.
	enabled := true.
	elementBuilder := self defaultElementBuilder 
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installListEventHandler [

	elementBuilder ifNil: [ ^ self ].
	listEventHandler := self newListEventHandler.
	listEventHandler selectionMode: self.
	listElement addEventHandler: listEventHandler

	

]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installOption [

	option := self defaultOption.
	option ifNil: [ ^ self ].
	option onInstalledIn: listElement
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> installSelecter [

	selecter := self newSelecter.
	selecter ifNil: [ ^ self ].
	selecter selectionModel: self newSelectionModel.
	selecter
		onInstalledIn: listElement;
		enabled: self enabled;
		multiple: self isMultipleSelection
]

{ #category : #testing }
ToAbstractListSelectionMode >> isDisabled [

	^ self enabled not
]

{ #category : #testing }
ToAbstractListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToAbstractListSelectionMode >> isMultipleSelection [

	^ self subclassResponsibility 
]

{ #category : #testing }
ToAbstractListSelectionMode >> isPrimary [

	^ false
]

{ #category : #testing }
ToAbstractListSelectionMode >> isSelectableNode: aNode [


	^ (self selectionModel containsIndex: aNode holder position)
			   and: [ aNode holder isHidden not ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> listElement [ 

	^ listElement 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> listEventHandlerClass [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newListEventHandler [

	^ self listEventHandlerClass new 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelecter [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionElement [

	^ elementBuilder value
		  selectionOption: option;
		  focused: listElement isFocused;
		  yourself
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModel [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: anElement [

	listElement := anElement.
	self installOption.
	self installSelecter.
	self installListEventHandler
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: anElement [

	self uninstallListEventHandler.
	self uninstallSelecter.
	self uninstallOption.
	listElement := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
]

{ #category : #accessing }
ToAbstractListSelectionMode >> option [

	^ option 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> option: aListSelectionOption [

	option ifNotNil: [ option onUninstalledIn: listElement ].
	option := aListSelectionOption.
	option ifNotNil: [ option onInstalledIn: listElement ]
]

{ #category : #accessing }
ToAbstractListSelectionMode >> optionDo: aBlock [

	option ifNil: [ ^ self ].
	aBlock value: option 
]

{ #category : #private }
ToAbstractListSelectionMode >> refreshSelectionIn: aListElement [

	option ifNil: [ ^ self ].
	option groupHolder refreshSelectionIn: aListElement
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexes [

	^ self selectionModel indexes
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectedIndexesCount [

	^ self selectionModel selectedIndexesCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter [

	^ selecter 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selecter: aSelecter [

	selecter := aSelecter
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> selectionChangedEventClass [ 

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionElements [

	^ option selectionElements
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallListEventHandler [

	listEventHandler ifNil: [ ^ self ].
	listEventHandler selectionMode: nil.
	listElement removeEventHandler: listEventHandler.
	listEventHandler := nil

	

]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallOption [

	option ifNil: [ ^ self ].
	option onUninstalledIn: listElement.
	option := nil
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> uninstallSelecter [

	selecter onUninstalledIn: listElement.
	selecter := nil
]

{ #category : #private }
ToAbstractListSelectionMode >> updateSelectionIn: aListElement [

	option groupHolder updateSelectionIn: aListElement
]
