Class {
	#name : #ToAlbumBasicModel,
	#superclass : #OBlElementCompanion,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#hasUnacceptedEdits => ObservableSlot',
		'#fontName => ObservableSlot',
		'#text => ObservableSlot',
		'#mode => ObservableSlot',
		'#stylerHolder'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'accessing - album' }
ToAlbumBasicModel >> albumDo: aBlock [

	self announce: (ToActionRequiredFromAlbum  new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumBasicModel >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #accessing }
ToAlbumBasicModel >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #accessing }
ToAlbumBasicModel >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #accessing }
ToAlbumBasicModel >> classOrMetaClass: aClass [

	self stylerHolder classOrMetaClass: aClass
]

{ #category : #initialization }
ToAlbumBasicModel >> defaultCodeFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumBasicModel >> defaultFontName [

	^ nil
	
]

{ #category : #initialization }
ToAlbumBasicModel >> defaultStyler [

	^ nil 
]

{ #category : #initialization }
ToAlbumBasicModel >> editStateChanged [


]

{ #category : #'accessing - album' }
ToAlbumBasicModel >> editorElementDo: aBlock [

	self announce: (AlbActionRequiredFromEditorElement new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumBasicModel >> fontName [

	^ fontName
]

{ #category : #accessing }
ToAlbumBasicModel >> fontName: aFontName [

	fontName = aFontName ifTrue: [ ^ self ].
	fontName := aFontName
]

{ #category : #initialization }
ToAlbumBasicModel >> fontNameChanged [

	self stylerHolder fontName: self fontName.
	self launchTextStyle

]

{ #category : #accessing }
ToAlbumBasicModel >> hasUnacceptedEdits [

	^ hasUnacceptedEdits ifNil: [ hasUnacceptedEdits := false ]
]

{ #category : #accessing }
ToAlbumBasicModel >> hasUnacceptedEdits: aBoolean [

	hasUnacceptedEdits = aBoolean ifTrue: [ ^ self ].
	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
ToAlbumBasicModel >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	fontName := self defaultFontName.
	
	" action when  mode change (Observable slot) "
	self whenModeChangedDo: [ :m | self modeChanged ].
		
	" action when  text change (Observable slot) "
	self whenTextChangedDo: [ :t | self textChanged ]	.
		
	" action when  font name change (Observable slot) "
	self whenFontNameChangedDo: [ :t | self fontNameChanged ].
	
	" action when  edite state change (Observable slot) "
	self whenEditStateChangedDo: [ :t | self editStateChanged ]
]

{ #category : #accessing }
ToAlbumBasicModel >> isForWorkspace: aBoolean [

	self stylerHolder isForWorkspace: aBoolean
]

{ #category : #'text style' }
ToAlbumBasicModel >> launchTextStyle [

	" ask the stylerHolder through its observale slot "
	self stylerHolderDo: [ self stylerHolder unstyledText: self text ]
]

{ #category : #accessing }
ToAlbumBasicModel >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumBasicModel >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode
]

{ #category : #initialization }
ToAlbumBasicModel >> modeChanged [

	self stylerHolderDo: [ 
		self launchTextStyle ]
]

{ #category : #'accessing - album' }
ToAlbumBasicModel >> onAlbum: anAlbum [

	self onInstalledIn: anAlbum
]

{ #category : #'api - hooks' }
ToAlbumBasicModel >> onInstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onInstalledIn: anAlbum.
	
	anAlbum withEditsFeedbackFromModel: self.
	self mode: anAlbum mode.
	self when: AlbActionRequiredFromEditorElement send: #whenActionRequired: to: anAlbum editorElement.
	self when: ToActionRequiredFromAlbum send: #whenActionRequired: to: anAlbum.
	
	anAlbum whenTextChangedDo: [:t | self text: t].
	anAlbum whenModeChangedDo: [:m | self mode: m].
	
	self whenTextChangedDo: [:t | anAlbum text: t].
	self whenModeChangedDo: [:m | anAlbum mode: m].
	
	anAlbum viewModel when: AlbTextModifiedByEditor send: #textModifiedByTextEditor to: self.
	anAlbum viewModel when: AlbSaveRequested send: #requestSave to: self.
	
	stylerHolder := AlbStylerHolder new
		                referentElement: anAlbum;
		                styler: self defaultStyler;
		                yourself.
	
	stylerHolder whenStyledTextChangedDo: [ :styledText | 
		self text takeInternalRepresentationOf: styledText.
		self editorElementDo: [ :element | element textInternalRepresentationChanged ] ].


]

{ #category : #'api - hooks' }
ToAlbumBasicModel >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	self unsubscribe: anAlbum editorElement.
	anAlbum viewModel unsubscribe: self.

	stylerHolder releaseStyler.
	stylerHolder := nil
]

{ #category : #'api-transaction' }
ToAlbumBasicModel >> requestSave [

	self announce: ToAlbumSaveRequested new.
	self saveResult: true
]

{ #category : #'api-transaction' }
ToAlbumBasicModel >> saveResult: aBoolean [

	| announcement |
	self hasUnacceptedEdits: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new ]
		                ifFalse: [ ToAlbumSaveDenied new ].
	self announce: announcement
]

{ #category : #accessing }
ToAlbumBasicModel >> styler: aStyler [

	self stylerHolder styler: (aStyler fontName: self defaultCodeFontName; yourself)
]

{ #category : #accessing }
ToAlbumBasicModel >> stylerHolder [

	^ stylerHolder
]

{ #category : #accessing }
ToAlbumBasicModel >> stylerHolderDo: aBlock [

	stylerHolder ifNil: [ ^self ].
	aBlock value
]

{ #category : #accessing }
ToAlbumBasicModel >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumBasicModel >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText

	
]

{ #category : #initialization }
ToAlbumBasicModel >> textChanged [

	" ask the stylerClient to style through its observal slot"
	self launchTextStyle
]

{ #category : #'api - hooks' }
ToAlbumBasicModel >> textModifiedByTextEditor [

	self hasUnacceptedEdits: true.
	self launchTextStyle
]

{ #category : #'slot - change hook' }
ToAlbumBasicModel >> unacceptedEditsDo: aBlock [

	aBlock value: self hasUnacceptedEdits
]

{ #category : #'slot - change hook' }
ToAlbumBasicModel >> whenEditStateChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #hasUnacceptedEdits whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumBasicModel >> whenFontNameChangedDo: aBlock [

	"set a block to perform after that the mode has been chanbed, and its action performed"

	self property: #fontName whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumBasicModel >> whenModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumBasicModel >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #accessing }
ToAlbumBasicModel >> workspace: aWorkspace [

	self stylerHolder workspace: aWorkspace
]
