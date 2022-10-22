"
I implement a typical Album user with a styler.
I'm a kind of model but without any association from the widget to the client (no reference to the client is stored in widget).
It can be used and subclassed to support comment and code editing, workspace implementation...

The different kind of Album using should use the available basic client class or subclass it for specific purpose.


Here is an example of a basic client to open an Album on the Collection>>#difference

| client |
client := ToAlbumBasicClient new.
client styler: BlRBTextStyler new.
client classOrMetaClass: self class.
client withLineNumbers.
client text: (Collection sourceCodeAt: #difference:).
client withGhostText: (('Styled code') asRopedText fontSize: 30; foreground: Color veryLightGray).
client withEditsFeedbackLayer.

client onAlbum openInOBlSpace.

"
Class {
	#name : #ToAlbumBasicClient,
	#superclass : #OBlElementCompanion,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#hasUnacceptedEdits => ObservableSlot',
		'#text',
		'#mode',
		'#stylerHolder',
		'#postponed'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'accessing - album' }
ToAlbumBasicClient >> albumDo: aBlock [

	self announce: (ToActionRequiredFromAlbum new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumBasicClient >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #accessing }
ToAlbumBasicClient >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #accessing }
ToAlbumBasicClient >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #accessing }
ToAlbumBasicClient >> classOrMetaClass: aClass [

	self stylerHolder classOrMetaClass: aClass
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultStyler [

	^ nil 
]

{ #category : #initialization }
ToAlbumBasicClient >> defaultText [

	^ '' asRopedText
	
]

{ #category : #'change hook' }
ToAlbumBasicClient >> editStateChanged [


]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> flushPostponed [

	postponed do: [ :announcement | self announce: announcement ].
	postponed := nil
]

{ #category : #accessing }
ToAlbumBasicClient >> hasUnacceptedEdits [

	^ hasUnacceptedEdits ifNil: [ hasUnacceptedEdits := false ]
]

{ #category : #accessing }
ToAlbumBasicClient >> hasUnacceptedEdits: aBoolean [

	hasUnacceptedEdits = aBoolean ifTrue: [ ^ self ].
	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
ToAlbumBasicClient >> initialize [

	self class initializeSlots: self.
	super initialize.
	
	
	postponed  := OrderedCollection new.	
	self when: ToActionRequiredFromAlbum send: #postponeActionRequiredOnAlbum: to: self.
	
	stylerHolder := AlbStylerHolder new
		                styler: self defaultStyler;
		                yourself.
		
	self text: self defaultText.
	
	" action when edit state change (Observable slot) "
	self whenEditStateChangedDo: [ :t | self editStateChanged ]
]

{ #category : #accessing }
ToAlbumBasicClient >> isForWorkspace: aBoolean [

	self stylerHolder isForWorkspace: aBoolean
]

{ #category : #'text style' }
ToAlbumBasicClient >> launchTextStyle [

	" ask the stylerHolder through its observale slot "
	self stylerHolder unstyledText: self text
]

{ #category : #accessing }
ToAlbumBasicClient >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumBasicClient >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self albumDo: [ :album | album mode: anEditabilityMode ]
]

{ #category : #'change hook' }
ToAlbumBasicClient >> modeChanged [


]

{ #category : #'accessing - album' }
ToAlbumBasicClient >> onAlbum [

	^ self onAlbum: ToAlbum new
]

{ #category : #'accessing - album' }
ToAlbumBasicClient >> onAlbum: anAlbum [

	self onInstalledIn: anAlbum.
	^ anAlbum
]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> onInstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledIn: anAlbum.
	
	self unsubscribe: self.
	self when: ToActionRequiredFromAlbum send: #whenActionRequired: to: anAlbum.

	self mode: anAlbum mode.

	anAlbum whenTextChangedDo: [ :t | self privateText: t ].
	anAlbum whenModeChangedDo: [ :m | self privateMode: m ].

	anAlbum viewModel when: AlbTextModifiedByEditor send: #whenTextModifiedByTextEditor: to: self.
	anAlbum viewModel when: AlbSaveRequested send: #requestSave to: self.

	stylerHolder referentElement: anAlbum.
	stylerHolder whenStyledTextChangedDo: [ :styledText | 
		self text takeInternalRepresentationOf: styledText.
		self albumDo: [ :album | album editorElement textInternalRepresentationChanged ] ].

	self flushPostponed.

]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveAcceptedDo: aBlock [

	self when: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveAcceptedSend: aSelector to: anObject [

	self when: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveDeniedDo: aBlock [

	self when: ToAlbumSaveDenied do: aBlock
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveDeniedSend: aSelector to: anObject [

	self when: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveRequestedDo: aBlock [

	self when: ToAlbumSaveRequested do: aBlock
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> onSaveRequestedSend: aSelector to: anObject [

	self when: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	anAlbum viewModel unsubscribe: self.
	self unsubscribe: anAlbum editorElement.
	self unsubscribe: anAlbum.
	stylerHolder releaseStyler
]

{ #category : #private }
ToAlbumBasicClient >> postponeActionRequiredOnAlbum: anActionRequiredFromAlbum [

	postponed add: anActionRequiredFromAlbum.
]

{ #category : #private }
ToAlbumBasicClient >> privateMode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode.
	self modeChanged
]

{ #category : #private }
ToAlbumBasicClient >> privateText: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	text := aBlText.
	self textChanged
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> requestSave [

	self announce: (ToAlbumSaveRequested new client: self)
]

{ #category : #'api-transaction' }
ToAlbumBasicClient >> saveResult: aBoolean [

	| announcement |
	self hasUnacceptedEdits: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #accessing }
ToAlbumBasicClient >> styler: aStyler [ 

	self stylerHolder styler: (aStyler fontName: self defaultCodeFontName; yourself)
]

{ #category : #accessing }
ToAlbumBasicClient >> stylerHolder [

	^ stylerHolder
]

{ #category : #accessing }
ToAlbumBasicClient >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumBasicClient >> text: aBlText [

	self text == aBlText ifTrue: [ ^ self ].
	self albumDo: [ :album | 
		album text: aBlText asRopedText]
]

{ #category : #'change hook' }
ToAlbumBasicClient >> textChanged [

	self announce: (ToAlbumTextModified new client: self; text: self text; yourself).
	" ask the stylerHolder to style through its observal slot"
	self launchTextStyle

]

{ #category : #'api - hooks' }
ToAlbumBasicClient >> unacceptedEditsDo: aBlock [

	aBlock value: self hasUnacceptedEdits
]

{ #category : #'private-change hook' }
ToAlbumBasicClient >> whenEditStateChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #hasUnacceptedEdits whenChangedDo: aBlock
]

{ #category : #'event management' }
ToAlbumBasicClient >> whenTextModifiedByTextEditor: aTextModifiedByEditorAnnouncement [

	self hasUnacceptedEdits: true.
	self textChanged

]

{ #category : #configuration }
ToAlbumBasicClient >> withEditsFeedbackLayer [

	self albumDo: [ :album | album withEditsFeedbackFrom: self. ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withGhostText: aText [

	self albumDo: [ :album | album withGhostText: aText from: self ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withLineNumbers [

	self albumDo: [ :album | album withLineNumbers ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutEditsFeedbackLayer [

	self albumDo: [ :album | album withoutEditsFeedback. ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutGhostText [

	self albumDo: [ :album | album withoutGhostText ]
]

{ #category : #configuration }
ToAlbumBasicClient >> withoutLineNumbers [

	self albumDo: [ :album | album withoutLineNumbers ]
]

{ #category : #accessing }
ToAlbumBasicClient >> workspace: aWorkspace [

	self stylerHolder workspace: aWorkspace
]
