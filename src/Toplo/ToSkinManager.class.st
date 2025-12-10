Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'styleSheet',
		'skinStateQueue',
		'newSkinRequested',
		'installedSkin',
		'isInstallingSkin',
		'preventedSkinEventClasses',
		'stampIndex',
		'tokenPropertyIndex'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'accessing - skin state queue' }
ToSkinManager >> applyEnqueuedStatesFor: anElement [
	" run the skin actually by flushing the state queue"

	" dispatch to the skin "

	installedSkin applyEnqueuedStatesFor: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> checkState: isChecked in: anElement [

	skinStateQueue checked: isChecked for: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> enablementState: isEnabled in: anElement [

	skinStateQueue enabled: isEnabled for: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> enqueueTransientState: aSkinState for: anElement [

	skinStateQueue enqueueTransientState: aSkinState for: anElement
]

{ #category : #accessing }
ToSkinManager >> ensuredPreventedSkinEventClasses [

	^ preventedSkinEventClasses ifNil: [
		  preventedSkinEventClasses := IdentitySet new ]
]

{ #category : #'accessing - stamps' }
ToSkinManager >> ensuredStampIndexIn: anElement [

	^ stampIndex ifNil: [
		  stampIndex := self newStampIndexIn: anElement ]
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> ensuredStyleSheetIn: anElement [

	self styleSheet ifNotNil: [ :curr | ^ curr].
	styleSheet := ToStyleSheet new.
	styleSheet onInstalledIn: anElement.
	^ styleSheet 
]

{ #category : #'accessing - token properties' }
ToSkinManager >> ensuredTokenPropertyIndexIn: anElement [

	^ tokenPropertyIndex ifNil: [
		  tokenPropertyIndex := self newTokenPropertyIndexIn: anElement ]
]

{ #category : #'skin state generation' }
ToSkinManager >> focusState: isFocused in: anElement [

	skinStateQueue focused: isFocused for: anElement
]

{ #category : #private }
ToSkinManager >> forceNewSkinRequested: aBoolean in: anElement [

	"*** private use only for tests *** "
	
	newSkinRequested := aBoolean.
	newSkinRequested ifFalse: [ ^ self ].
	anElement space needSkinInstallPass: true
]

{ #category : #initialization }
ToSkinManager >> initialize [

	super initialize.

	isInstallingSkin := false.
	newSkinRequested := false.
	installedSkin := ToUnknownSkin instance.
	skinStateQueue := ToSkinStateQueue new
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installNewSkinIn: anElement [
	" actually install the skin if requested "

	newSkinRequested ifFalse: [ ^ self ].
	isInstallingSkin ifTrue: [ ^ self ].
	self installingWhile: [
			self uninstallSkinIn: anElement.
			(self skinToInstallIn: anElement) ifNotNil: [ :skin |
				self installSkin: skin in: anElement ].
			" check skin installation "
			installedSkin isUnknownSkin ifTrue: [
				Error signal: 'The skin remains unknown' ].
			" apply style here directly to benefit from the installer recursion protection
					because  requestNewSkin may be sent during skin installation 
					(in that case it it ignored) "
			self applyEnqueuedStatesFor: anElement.
			newSkinRequested := false ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

	" store the skin "
	installedSkin := aSkin.
	anElement addEventHandler: installedSkin.
	self skinStateQueue enqueueInstallStateFor: anElement
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ installedSkin
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkinDo: aBlock [

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	aBlock value: installedSkin
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installingWhile: aBlock [

	isInstallingSkin ifTrue: [
			'Asking to install a skin while a skin is currently under installation'
				traceCr.
			^ self ].
	isInstallingSkin := true.
	aBlock ensure: [ isInstallingSkin := false ]
]

{ #category : #accessing }
ToSkinManager >> newSkinRequested [

	^ newSkinRequested
]

{ #category : #'accessing - stamps' }
ToSkinManager >> newStampIndexIn: anElement [

	^ ToPropertyIndexWithChangedAction new
		  changedAction: [
				  self requestNewSkinRecursivelyFrom: anElement.
				  anElement requestSkinApplication ];
		  yourself
]

{ #category : #'accessing - token properties' }
ToSkinManager >> newTokenPropertyIndexIn: anElement [

	^ ToPropertyIndexWithChangedAction new
		  changedAction: [
				  self requestNewSkinRecursivelyFrom: anElement.
				  anElement requestSkinApplication ];
		  yourself
]

{ #category : #accessing }
ToSkinManager >> preventedSkinEventClasses [

	^ preventedSkinEventClasses 
]

{ #category : #'t - token property index holder' }
ToSkinManager >> rawTokenPropertyIndex [

	^ tokenPropertyIndex
]

{ #category : #'t - token property index holder' }
ToSkinManager >> rawTokenPropertyIndex: aPropertyIndex [

	tokenPropertyIndex := aPropertyIndex
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestNewSkinIn: anElement [

	newSkinRequested := true.
	" *** Important point: a skin can be installed instantly.
	This is used to avoid visual flashing effects or lags in some situations: 
	selection or labels updating in lists as examples. 
	But but but it is possible only at the first request. Why ?
	Because requestInstallSkin can be sent many times 
	(as an example during a theme installation). 
	Thus, applying each request instantly could increase time consuming for nothing **** "
	anElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	installedSkin isUnknownSkin ifFalse: [
			anElement space needSkinInstallPass: true.
			^ self ].
	" then apply the installer now "
	" but before, apply the uninstaller if any"
	"skinUninstaller ifNotNil: [ :u | u applyOn: anElement ]."
	" finally install the skin"
	self installNewSkinIn: anElement
]

{ #category : #'api - hooks' }
ToSkinManager >> requestNewSkinRecursivelyFrom: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child requestNewSkin ]
]

{ #category : #'skin state generation' }
ToSkinManager >> selectionState: isSelected selectionOption: aSelectionOption focused: isFocused in: anElement [

	anElement
		withAllChildrenBreadthFirstDo: [ :child |
				child skinManagerDo: [ :sm |
						sm skinStateQueue
							selected: isSelected
							selectionOption: aSelectionOption
							focused: isFocused
							for: child ] ]
		while: [ :child | child selectionSkinEventsPrevented not ]
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> setStyleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUninstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ].
	anElement requestSkinApplication
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinToInstallIn: anElement [

	| theme skin |
	theme := anElement lookupTheme.
	skin := theme defaultSkinFor: anElement.
	skin setUpforElement: anElement inTheme: theme.
	^ skin
]

{ #category : #'accessing - stamps' }
ToSkinManager >> stampIndex [

	^ stampIndex
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> styleSheet [

	^ styleSheet 
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> styleSheet: anObject [

	styleSheet := anObject
]

{ #category : #'accessing - token properties' }
ToSkinManager >> tokenPropertyIndex [

	^ tokenPropertyIndex
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkinIn: anElement [
	" uninstall the skin "

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	self skinStateQueue enqueueUninstallStateFor: anElement.
	anElement removeEventHandler: installedSkin.
	installedSkin := ToUnknownSkin instance
]
