Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selecter',
		'selectionOption',
		'dirty'
	],
	#category : #'Toplo-Widget-List-Selection-Mode'
}

{ #category : #accessing }
ToAbstractListSelectionMode >> changeSelectionOptionWith: aSelectionOption [

	| listElement |
	listElement := selecter element.
	selectionOption ifNotNil: [
		selectionOption onUninstalledIn: listElement ].
	selectionOption := aSelectionOption.
	selectionOption ifNil: [ ^ self ].
	selectionOption selectionMode: self.
	selectionOption onInstalledIn: listElement
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> checkSelectionIn: aListElement [

	self dirty ifFalse: [ ^ self ].
	self ensureCleanAfter: [
			self selectionOption ifNotNil: [ :option |
				option updateRepresentationIn: aListElement ] ]
]

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultSelectionOption [

	^ self subclassResponsibility 
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> deselectionSkinEventClass [ 

	^ selectionOption deselectionSkinEventClass
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> deselectionSkinEventClass: aSkinEventClass [ 

	selectionOption deselectionSkinEventClass: aSkinEventClass
]

{ #category : #accessing }
ToAbstractListSelectionMode >> dirty [

	^ dirty
]

{ #category : #accessing }
ToAbstractListSelectionMode >> dirty: aBoolean [

	dirty := aBoolean
]

{ #category : #accessing }
ToAbstractListSelectionMode >> doubleClickTimeout [

	^ 200 milliSeconds 
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> ensureCleanAfter: aBlock [

	" ensure not dirty after to avoid multiple useless recursions "
	aBlock value.
	self dirty: false
]

{ #category : #initialization }
ToAbstractListSelectionMode >> initialize [

	super initialize.
	dirty := true
]

{ #category : #testing }
ToAbstractListSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #testing }
ToAbstractListSelectionMode >> isPrimary [

	^ false
]

{ #category : #testing }
ToAbstractListSelectionMode >> isSecondary [

	^ false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> itemCount [

	^ self selectionModel itemCount
]

{ #category : #accessing }
ToAbstractListSelectionMode >> makeDisabledUnselectable [

	^ self selectionModel makeDisabledUnselectable
]

{ #category : #accessing }
ToAbstractListSelectionMode >> makeDisabledUnselectable: aBoolean [

	self selectionModel makeDisabledUnselectable: aBoolean
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelecter [

	^ self subclassResponsibility 
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionChangedEventHandler [

	^ nil
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionContainerIn: aListElement [

	| container |
	container := ToListSelectionContainer new.
	container id: self class name asSymbol.
	container attachTo: aListElement.
	^ container
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModelIn: aListElement [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onInstalledIn: aListElement [

	aListElement addSelectionMode: self.
	self newSelectionChangedEventHandler ifNotNil: [ :handler |
		aListElement addEventHandler: handler ].
	selecter := self newSelecter.
	selecter selectionMode: self.
	selecter selectionModel: (self newSelectionModelIn: aListElement).
	selecter selectionChangedEventClass: self selectionChangedEventClass.
	selecter multiple: self isMultipleSelection.
	selecter onInstalledIn: aListElement.
	selectionOption := self defaultSelectionOption.
	selectionOption selectionMode: self.
	selectionOption onInstalledIn: aListElement
]

{ #category : #'api - hooks' }
ToAbstractListSelectionMode >> onUninstalledIn: aListElement [

	selectionOption ifNotNil: [
		selectionOption onUninstalledIn: aListElement ].
	selecter onUninstalledIn: aListElement.
	aListElement removeSelectionMode: self.
	selectionOption := nil.
	selecter := nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> operator [

	^ selecter operator
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
ToAbstractListSelectionMode >> selectionContainer [

	^ selectionOption selectionContainer
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionModel [

	^ selecter selectionModel
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionOption [

	^ selectionOption 
]

{ #category : #accessing }
ToAbstractListSelectionMode >> selectionOptionDo: aBlock [

	aBlock value: selectionOption
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> selectionSkinEventClass [ 

	^ selectionOption selectionSkinEventClass
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> selectionSkinEventClass: aSkinEventClass [ 

	selectionOption selectionSkinEventClass: aSkinEventClass
]

{ #category : #'selection updating' }
ToAbstractListSelectionMode >> updateSelectionIn: aListElement [

	self ensureCleanAfter: [
			self selectionOption ifNotNil: [ :option |
				option updateRepresentationIn: aListElement ] ]
]

{ #category : #initialization }
ToAbstractListSelectionMode >> withDefaultSelectionSkinEvents [


]

{ #category : #initialization }
ToAbstractListSelectionMode >> withoutSelectionSkinEvents [

	^ selectionOption
		  selectionSkinEventClass: nil;
		  deselectionSkinEventClass: nil
]
