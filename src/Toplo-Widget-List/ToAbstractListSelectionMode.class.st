Class {
	#name : #ToAbstractListSelectionMode,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'selecter',
		'selectionOption'
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

{ #category : #initialization }
ToAbstractListSelectionMode >> defaultSelectionOption [

	^ nil
]

{ #category : #accessing }
ToAbstractListSelectionMode >> disable [

	self enabled: false
]

{ #category : #accessing }
ToAbstractListSelectionMode >> doubleClickTimeout [

	^ 200 milliSeconds 
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
	enabled := true
]

{ #category : #testing }
ToAbstractListSelectionMode >> isContextMenu [

	^ false
]

{ #category : #testing }
ToAbstractListSelectionMode >> isDisabled [

	^ false
]

{ #category : #testing }
ToAbstractListSelectionMode >> isEnabled [

	^ self enabled
]

{ #category : #testing }
ToAbstractListSelectionMode >> isHidden [

	^ false
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

{ #category : #testing }
ToAbstractListSelectionMode >> isUnselectable [

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

	| container elevation |
	container := ToOverlayElement new.
	container clipChildren: true.
	container attachTo: aListElement.
	elevation := self selectionOption isBeneath 
		             ifTrue: [ BlRelativeElevation elevation: 5 ]
		             ifFalse: [ BlRelativeElevation elevation: 15 ].
	container elevation: elevation.
	^ container
]

{ #category : #'instance creation' }
ToAbstractListSelectionMode >> newSelectionModelIn: aListElement [

	^ self subclassResponsibility 
]

{ #category : #initialization }
ToAbstractListSelectionMode >> on: aListElement [

	self
		deprecated: 'Use #onInstalledIn:'
		transformWith: '`@rcvr on: `@arg' -> '`@rcvr onInstalledIn: `@arg'.
	self onInstalledIn: aListElement
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
	selecter enabled: self enabled.
	selecter multiple: self isMultipleSelection.
	selecter onInstalledIn: aListElement.
	selectionOption := self defaultSelectionOption.
	selectionOption ifNil: [ ^ self ].
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
ToAbstractListSelectionMode >> option [

	self
		deprecated: 'Use #selectionOption'
		transformWith:
		'`@rcvr option' -> '`@rcvr selectionOption'.

	^ self selectionOption
]

{ #category : #accessing }
ToAbstractListSelectionMode >> requestNewRepresentation [

	self selectionOptionDo: [ :rep | rep requestNewRepresentation ]
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
ToAbstractListSelectionMode >> selectionElementOption [

	self
		deprecated: 'Use #selectionOption'
		transformWith:
		'`@rcvr selectionElementOption' -> '`@rcvr selectionOption'.

	^ self selectionOption
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

	selectionOption ifNil: [ ^ self ].
	aBlock value: selectionOption
]
