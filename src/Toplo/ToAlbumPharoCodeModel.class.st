Class {
	#name : #ToAlbumPharoCodeModel,
	#superclass : #OBlElementCompanion,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#stylerHolder',
		'#hasUnacceptedEdits => ObservableSlot',
		'#fontName => ObservableSlot',
		'#text => ObservableSlot',
		'#mode => ObservableSlot'
	],
	#category : #'Toplo-Widgets'
}

{ #category : #'accessing - album' }
ToAlbumPharoCodeModel >> albumDo: aBlock [

	self announce: (ToActionRequiredFromAlbum  new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> beEditable [

	self mode: AlbEditableMode new
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> beReadonlyWithSelection [

	self mode: AlbReadonlyWithSelectionMode new
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> beReadonlyWithoutSelection [

	self mode: AlbReadonlyWithoutSelectionMode new
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> classOrMetaClass: aClass [

	self stylerHolder classOrMetaClass: aClass
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> defaultFontName [

	^ AeFontManager defaultCodeFontFamilyName
	
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> defaultStyler [

	^ BlRBTextStyler new fontName: self fontName 
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> editStateChanged [


]

{ #category : #'accessing - album' }
ToAlbumPharoCodeModel >> editorElementDo: aBlock [

	self announce: (AlbActionRequiredFromEditorElement new
			 valuable: aBlock;
			 yourself)
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> fontName [

	^ fontName
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> fontName: aFontName [

	fontName = aFontName ifTrue: [ ^ self ].
	fontName := aFontName
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> fontNameChanged [

	self stylerHolder fontName: self fontName.
	self launchTextStyle

]

{ #category : #accessing }
ToAlbumPharoCodeModel >> hasUnacceptedEdits [

	^ hasUnacceptedEdits ifNil: [ hasUnacceptedEdits := false ]
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> hasUnacceptedEdits: aBoolean [

	hasUnacceptedEdits = aBoolean ifTrue: [ ^ self ].
	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> initialize [
	
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
ToAlbumPharoCodeModel >> isForWorkspace: aBoolean [

	self stylerHolder isForWorkspace: aBoolean
]

{ #category : #'text style' }
ToAlbumPharoCodeModel >> launchTextStyle [

	" ask the stylerHolder through its observale slot "
	self stylerHolderDo: [ self stylerHolder unstyledText: self text ]
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> mode [

	^ mode

	
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> mode: anEditabilityMode [

	mode = anEditabilityMode ifTrue: [ ^ self ].
	mode := anEditabilityMode
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> modeChanged [

	self stylerHolderDo: [ 
		
		self launchTextStyle ]
]

{ #category : #'accessing - album' }
ToAlbumPharoCodeModel >> onAlbum: anAlbum [

	self onInstalledIn: anAlbum
]

{ #category : #'api - hooks' }
ToAlbumPharoCodeModel >> onInstalledIn: anAlbum [

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
ToAlbumPharoCodeModel >> onUninstalledIn: anAlbum [

	"Is sent when I am added to an element "

	super onUninstalledIn: anAlbum.
	self unsubscribe: anAlbum editorElement.
	anAlbum viewModel unsubscribe: self.
	stylerHolder releaseStyler.
	stylerHolder := nil
]

{ #category : #'api-transaction' }
ToAlbumPharoCodeModel >> requestSave [

	self announce: ToAlbumSaveRequested new.
	self saveResult: true
]

{ #category : #'api-transaction' }
ToAlbumPharoCodeModel >> saveResult: aBoolean [

	| announcement |
	self hasUnacceptedEdits: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new ]
		                ifFalse: [ ToAlbumSaveDenied new ].
	self announce: announcement
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> stylerHolder [

	^ stylerHolder
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> stylerHolderDo: aBlock [

	stylerHolder ifNil: [ ^self ].
	aBlock value
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> text [

	^ text

	
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText

	
]

{ #category : #initialization }
ToAlbumPharoCodeModel >> textChanged [

	" ask the stylerClient to style through its observal slot"
	self launchTextStyle
]

{ #category : #'api - hooks' }
ToAlbumPharoCodeModel >> textModifiedByTextEditor [

	self hasUnacceptedEdits: true.
	self launchTextStyle
]

{ #category : #'slot - change hook' }
ToAlbumPharoCodeModel >> unacceptedEditsDo: aBlock [

	aBlock value: self hasUnacceptedEdits
]

{ #category : #'slot - change hook' }
ToAlbumPharoCodeModel >> whenEditStateChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #hasUnacceptedEdits whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumPharoCodeModel >> whenFontNameChangedDo: aBlock [

	"set a block to perform after that the mode has been chanbed, and its action performed"

	self property: #fontName whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumPharoCodeModel >> whenModeChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #mode whenChangedDo: aBlock
]

{ #category : #'slot - change hook' }
ToAlbumPharoCodeModel >> whenTextChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #accessing }
ToAlbumPharoCodeModel >> workspace: aWorkspace [

	self stylerHolder workspace: aWorkspace
]
