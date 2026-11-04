"
I implement type-ahead search for a list element: typing letters, digits, $_ or $: selects the first item matching the typed pattern, which is shown in a small overlay.
Escape clears the pattern, Backspace removes its last character, and it is cleared automatically after resetDelay without typing.

The matcher is a block [ :item :pattern | ... ] answering whether item matches (case-insensitive prefix by default).

Enable me with ToBasicListElement>>enableTypeAhead.
"
Class {
	#name : #ToListTypeAheadEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'listElement',
		'matcher',
		'pattern',
		'resetDelay',
		'lastInputTime',
		'resetTask',
		'overlay'
	],
	#category : #'Toplo-Widget-List-TypeAhead'
}

{ #category : #'event handling' }
ToListTypeAheadEventHandler >> blurEvent: anEvent [

	self reset
]

{ #category : #initialization }
ToListTypeAheadEventHandler >> defaultMatcher [

	^ [ :item :aPattern | item asString asLowercase beginsWith: aPattern asLowercase ]
]

{ #category : #'api - accessing' }
ToListTypeAheadEventHandler >> eventsToHandle [

	^ {
		  BlTextInputEvent.
		  BlKeyDownEvent.
		  BlBlurEvent }
]

{ #category : #testing }
ToListTypeAheadEventHandler >> hasCommandModifier: aKeyModifiers [

	^ aKeyModifiers isCtrl or: [ aKeyModifiers isAlt or: [ aKeyModifiers isCmd ] ]
]

{ #category : #initialization }
ToListTypeAheadEventHandler >> initialize [

	super initialize.
	pattern := ''.
	resetDelay := 1 second.
	matcher := self defaultMatcher
]

{ #category : #testing }
ToListTypeAheadEventHandler >> isAcceptedText: aString [

	^ aString isNotEmpty and: [ aString allSatisfy: [ :each | each isAlphaNumeric or: [ #( $_ $: ) includes: each ] ] ]
]

{ #category : #testing }
ToListTypeAheadEventHandler >> isAimedAtList: anEvent [
	"Ignore events aimed at a child element, such as a text field in a row"

	^ anEvent target == anEvent currentTarget
]

{ #category : #'event handling' }
ToListTypeAheadEventHandler >> keyDownEvent: anEvent [

	(self isAimedAtList: anEvent) ifFalse: [ ^ self ].
	pattern ifEmpty: [ ^ self ].
	anEvent key = KeyboardKey escape ifTrue: [
			anEvent consume.
			^ self reset ].
	anEvent key = KeyboardKey backspace ifFalse: [ ^ self ].
	anEvent consume.
	^ self removeLastCharacter
]

{ #category : #accessing }
ToListTypeAheadEventHandler >> matcher: aBlock [

	matcher := aBlock
]

{ #category : #'api - hooks' }
ToListTypeAheadEventHandler >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	listElement := anElement
]

{ #category : #'api - hooks' }
ToListTypeAheadEventHandler >> onUninstalledIn: anElement [

	self reset.
	super onUninstalledIn: anElement.
	listElement := nil
]

{ #category : #accessing }
ToListTypeAheadEventHandler >> overlay [

	^ overlay
]

{ #category : #accessing }
ToListTypeAheadEventHandler >> pattern [

	^ pattern
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> removeLastCharacter [

	pattern := pattern allButLast.
	pattern ifEmpty: [ ^ self reset ].
	self search.
	self showOverlay
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> reset [

	pattern := ''.
	resetTask ifNotNil: [
			resetTask stop.
			listElement dequeueTask: resetTask.
			resetTask := nil ].
	overlay ifNotNil: [
			overlay detachFromParent.
			overlay := nil ]
]

{ #category : #accessing }
ToListTypeAheadEventHandler >> resetDelay [

	^ resetDelay
]

{ #category : #accessing }
ToListTypeAheadEventHandler >> resetDelay: aDuration [

	resetDelay := aDuration
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> resetIfIdle [

	listElement space time now - lastInputTime >= resetDelay ifTrue: [ self reset ]
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> search [

	| dataSource index |
	dataSource := listElement dataSource.
	index := dataSource detectIndex: [ :each | matcher value: each unwrappedDataItem value: pattern ] ifNone: [ ^ self ].
	listElement selecter selectOnlyIndex: index.
	listElement selecter scrollToDataSourcePosition: index
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> showOverlay [

	overlay ifNil: [
			overlay := ToListTypeAheadOverlay new.
			overlay attachToParent: listElement ].
	overlay pattern: pattern
]

{ #category : #'type-ahead' }
ToListTypeAheadEventHandler >> startResetTask [

	resetTask ifNotNil: [ ^ self ].
	resetTask := BlRepeatedTaskAction new
		             delay: 200 milliSeconds;
		             action: [ self resetIfIdle ].
	listElement enqueueTask: resetTask
]

{ #category : #'event handling' }
ToListTypeAheadEventHandler >> textInputEvent: anEvent [

	(self isAimedAtList: anEvent) ifFalse: [ ^ self ].
	(self hasCommandModifier: anEvent modifiers) ifTrue: [ ^ self ].
	(self isAcceptedText: anEvent text) ifFalse: [ ^ self ].
	anEvent consume.
	pattern := pattern , anEvent text asString.
	lastInputTime := listElement space time now.
	self search.
	self showOverlay.
	self startResetTask
]
