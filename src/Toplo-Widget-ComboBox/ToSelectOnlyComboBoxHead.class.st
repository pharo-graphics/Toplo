Class {
	#name : #ToSelectOnlyComboBoxHead,
	#superclass : #ToComboBoxHead,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'placeholder',
		'dataElementFactory'
	],
	#category : 'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> addShortCuts [

	| downShortcut upShortcut crShortcut escShortcut |
	downShortcut := BlShortcutWithAction new
		                combination: BlKeyCombination arrowDown;
		                action: [ :event | self arrowDownEvent: event ];
		                name: 'Popup';
		                yourself.
	upShortcut := BlShortcutWithAction new
		                combination: BlKeyCombination arrowUp;
		                action: [ :event | self arrowUpEvent: event ];
		                name: 'Popup';
		                yourself.

	crShortcut := BlShortcutWithAction new
		              combination: (BlKeyCombination primaryReturn or: BlKeyCombination return);
		              action: [
			              self comboBox listElement primarySelectionIndexes ifNotEmpty: [
					              :idxes |
					              self comboBox selectIndexInPresentedData: idxes first.
					              self comboBox close ] ];
		              name: 'Accept';
		              yourself.
	escShortcut := BlShortcutWithAction new
		               combination: BlKeyCombination escape;
		               action: [ self comboBox close ];
		               name: 'Escape';
		               yourself.

	self  addShortcut: downShortcut.
	self addShortcut: upShortcut.
	self addShortcut: crShortcut.
	self addShortcut: escShortcut
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> arrowDownEvent: anEvent [

	| wasOpened |
	wasOpened := self comboBox isOpened.
	wasOpened ifFalse: [
		self comboBox popupEvent: anEvent.
		self comboBox listElement selectedIndexes ifNotEmpty: [ ^ self ] ].
	anEvent consumed: false.
	self comboBox listElement infinite fireEvent: anEvent
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> arrowUpEvent: anEvent [

	| wasOpened |
	wasOpened :=  self comboBox isOpened.
	wasOpened ifFalse: [ ^ self ].
	anEvent consumed: false.
	self comboBox listElement infinite fireEvent: anEvent
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElement: anElement [

	anElement ifNil: [ ^ self ].
	anElement constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement removeChildren.
	innerElement addChild: anElement
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElementFactory [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	^ dataElementFactory
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElementFactory: aValuable [
	" aValuable takes 2 args : the node to builder and second its holder (to get the associated data) "

	dataElementFactory := aValuable 
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> defaultDataElementFactory [

	^  [ :node :holder | node addChild: (ToLabel text: holder data asString) ] 
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> defaultEventHandler [

	^ ToComboBoxHeadEventHandler new
]

{ #category : #'t - placeholder show/hide' }
ToSelectOnlyComboBoxHead >> hidePlaceholder [

	self placeholder ifNotNil: [ :ph |
		ph parentDo: [ :p | self placeholder removeFromParent ] ]
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> initialize [ 

	super initialize.
	self dataElementFactory: self defaultDataElementFactory.
	placeholder := self defaultPlaceholder.
	self addShortCuts.
	self addEventHandler: self defaultEventHandler
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> placeholder: anElement [

	placeholder = anElement ifTrue: [ ^ self ].
	placeholder ifNotNil: [ placeholder parentDo: [ :p | placeholder removeFromParent ] ].
	placeholder := (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> selectData: aData in: aComboBox [

	self hidePlaceholder.
	self dataElement: (self dataElementFactory cull: aData cull: self)
]

{ #category : #'t - placeholder show/hide' }
ToSelectOnlyComboBoxHead >> showPlaceholder [

	self dataElement: self placeholder
]
