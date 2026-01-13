"
I store all BlElement variables that are toplo specific
"
Class {
	#name : #ToElementExtension,
	#superclass : #Object,
	#instVars : [
		'skinManager',
		'stampMap',
		'tokenPropertyMap',
		'shortcutsStore',
		'styleSheet',
		'installedTheme',
		'borderBuilder',
		'defaultSkin',
		'enabled',
		'floatOverlay',
		'nextConfigurationPass',
		'textAttributesBuilder'
	],
	#category : #'Toplo-Core'
}

{ #category : #'accessing - border builder' }
ToElementExtension >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ]
]

{ #category : #'accessing - default skin' }
ToElementExtension >> defaultSkin [ 

	^ defaultSkin
]

{ #category : #'accessing - default skin' }
ToElementExtension >> defaultSkin: aSkin in: anElement [

	defaultSkin = aSkin ifTrue: [ ^ self ].
	defaultSkin := aSkin.
	anElement requestNewSkin
]

{ #category : #accessing }
ToElementExtension >> enabled [

	^ enabled ifNil: [ enabled := true ]
]

{ #category : #accessing }
ToElementExtension >> enabled: aBoolean [

	enabled := aBoolean
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> ensureHaveSkinManager [

	skinManager ifNil: [ skinManager := self newSkinManager ]
]

{ #category : #'accessing - shortcuts' }
ToElementExtension >> ensuredShortcutsStoreIn: anElement [

	^ shortcutsStore ifNil: [ shortcutsStore := anElement newShortcutsStore ]
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> ensuredSkinManager [

	self ensureHaveSkinManager.
	^ skinManager
]

{ #category : #'accessing - stamp map' }
ToElementExtension >> ensuredStampMapIn: anElement [

	^ stampMap ifNil: [
		  stampMap := self newStampMapIn: anElement ]
]

{ #category : #'accessing - stylesheet' }
ToElementExtension >> ensuredStyleSheetIn: anElement [

	^ styleSheet ifNil: [
			  styleSheet := ToStyleSheet new
				                onInstalledIn: anElement;
				                yourself ]
]

{ #category : #'accessing - token properties' }
ToElementExtension >> ensuredTokenPropertyMapIn: anElement [

	^ tokenPropertyMap ifNil: [
		  tokenPropertyMap := self newTokenPropertyMapIn: anElement ]
]

{ #category : #accessing }
ToElementExtension >> floatOverlayIn: anElement [

	^ floatOverlay ifNil: [
			  floatOverlay := ToFloatOverlay new
				                  attachToParent: anElement;
				                  yourself ]
]

{ #category : #'accessing - theme' }
ToElementExtension >> installedTheme [ 

	^ installedTheme 
]

{ #category : #'accessing - theme' }
ToElementExtension >> installedTheme: aTheme [ 

	installedTheme := aTheme
]

{ #category : #'accessing - theme' }
ToElementExtension >> installedThemeDo: aBlock [ 

	^ installedTheme ifNotNil: [ :it | aBlock cull: it ]
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> newSkinManager [

	^ self skinManagerClass new
]

{ #category : #'accessing - stamp map' }
ToElementExtension >> newStampMapIn: anElement [

	^ ToPropertyIndexWithChangedAction new
		  changedAction: [
				  self requestNewSkinRecursivelyFrom: anElement.
				  anElement requestSkinApplication ];
		  yourself
]

{ #category : #'accessing - token properties' }
ToElementExtension >> newTokenPropertyMapIn: anElement [

	^ ToPropertyIndexWithChangedAction new
		  changedAction: [
				  self requestNewSkinRecursivelyFrom: anElement.
				  anElement requestSkinApplication ];
		  yourself
]

{ #category : #accessing }
ToElementExtension >> nextConfigurationPass [

	^ nextConfigurationPass ifNil: [ nextConfigurationPass := 0 ]
]

{ #category : #accessing }
ToElementExtension >> nextConfigurationPass: aNumber [

	nextConfigurationPass := aNumber
]

{ #category : #'skin managing' }
ToElementExtension >> requestNewSkinRecursivelyFrom: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child requestNewSkin ]
]

{ #category : #'accessing - stylesheet' }
ToElementExtension >> setStyleSheet: aStyleSheet in: anElement [

	styleSheet ifNotNil: [ :prev | prev onUninstalledIn: anElement ].
	styleSheet := aStyleSheet.
	styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ].
	anElement requestSkinApplication
]

{ #category : #'accessing - shortcuts' }
ToElementExtension >> shortcutsStoreDo: aValuable [

	shortcutsStore ifNotNil: [ :store | aValuable cull: store ].
	
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> skinManager [

	^ skinManager
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> skinManagerClass [

	^ ToSkinManager
]

{ #category : #'accessing - skin manager' }
ToElementExtension >> skinManagerDo: aBlock [

	skinManager ifNotNil: [ :sm | ^ aBlock value: sm ].
	^ nil
]

{ #category : #'accessing - stamp map' }
ToElementExtension >> stampMap [

	^ stampMap 
]

{ #category : #'accessing - stamp map' }
ToElementExtension >> stampMapDo: aBlock [

	^ stampMap ifNotNil: [ :map | aBlock value: map ]
]

{ #category : #'accessing - stylesheet' }
ToElementExtension >> styleSheet [

	^ styleSheet 
]

{ #category : #'accessing - text attribute builder' }
ToElementExtension >> textAttributesBuilder [

	^ textAttributesBuilder
]

{ #category : #'accessing - text attribute builder' }
ToElementExtension >> textAttributesBuilderIn: anElement [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := anElement newTextAttributesBuilder ]
]

{ #category : #'accessing - token properties' }
ToElementExtension >> tokenPropertyMap [

	^ tokenPropertyMap
]

{ #category : #'accessing - token properties' }
ToElementExtension >> tokenPropertyMapDo: aBlock [

	^ tokenPropertyMap ifNotNil: [ :tpm | aBlock cull: tpm ]
]
