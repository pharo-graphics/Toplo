Class {
	#name : #ToAutocompleteEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'windowManager',
		'window',
		'windowPosition',
		'queryRunner'
	],
	#category : #'Toplo-Widget-Album-TextPane'
}

{ #category : #'event handling' }
ToAutocompleteEventHandler >> cursorElementMovedEvent: anEvent [

	| cursorElement bnds |
	cursorElement := anEvent currentTarget cursorElement.
	bnds := cursorElement bounds inSpace bounds.
	bnds height isZero ifTrue: [ ^ self ].
	windowPosition := bnds bottomRight.
	window popupEvent: anEvent
]

{ #category : #'api - accessing' }
ToAutocompleteEventHandler >> eventsToHandle [

	^ {
		  AlbCursorElementMovedEvent.
		  AlbTextInsertedEvent.
		  AlbTextDeletedEvent.
		  ToItemsQueryResultEvent }
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> itemsQueryResultEvent: aItemsQueryResultEvent [

	(aItemsQueryResultEvent items collect: [ :m | m ]) asArray in: [
		:result |
		result size trace.
		'->' trace.
		(result first: (5 min: result size)) traceCr ]
]

{ #category : #'api - hooks' }
ToAutocompleteEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	queryRunner := ToItemsQueryRunner new.
	queryRunner onInstalledIn: anElement.
	queryRunner fetcher: [ :theTextField :thePattern |
		(SystemNavigation default allMethods collect: [ :m | m selector ])
			asSet asArray sort select: [ :m |
			m beginsWith: thePattern caseSensitive: false ] ].
	
	windowManager := ToAnchoredWindowManager new.
	windowManager onInstalledIn: anElement.
	windowManager builder: [ :anchWin :element |
		anchWin addChild: (BlElement new
				 size: 50 @ 70;
				 background: Color red;
				 yourself) ].

	windowManager positionHook: [ :theWindow :theElement :event |
		theElement enqueueTask: (BlTaskAction new action: [
				 theWindow position: self windowPosition]) ].
	window := windowManager newWindowEvent: nil
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> textDeletedEvent: aTextDeletedEvent [

	| sub selecter wordStart currIdx album |
	album := aTextDeletedEvent currentTarget.
	currIdx := aTextDeletedEvent fromIndex - 1.
	selecter := album selecter.
	wordStart := selecter findWordStartBefore: currIdx.
	sub := album text copyFrom: wordStart to: currIdx.
	sub asString ifNotEmpty: [ :pat |
		queryRunner processPattern: pat for: album ]
]

{ #category : #'event handling' }
ToAutocompleteEventHandler >> textInsertedEvent: aTextEditedEvent [

	| sub selecter wordStart currIdx album |
	album := aTextEditedEvent currentTarget.
	currIdx := aTextEditedEvent toIndex.
	selecter := album selecter.
	wordStart := selecter findWordStartBefore: currIdx.
	sub := album text copyFrom: wordStart to: currIdx.
	sub asString ifNotEmpty: [ :pat |
		queryRunner processPattern: pat for: album ]
]

{ #category : #accessing }
ToAutocompleteEventHandler >> windowPosition [ 

	^ windowPosition 
]
