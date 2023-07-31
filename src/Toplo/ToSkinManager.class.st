Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinIndex',
		'newSkinList',
		'installedSkinList'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #initialization }
ToSkinManager >> initialize [ 

	super initialize.
	skinIndex := IdentityDictionary new.
	newSkinList := LinkedList new.
	installedSkinList := LinkedList new
]

{ #category : #'skin managing' }
ToSkinManager >> installSkins [

	self newSkinList do: [ :s | s launchInstallation ].
]

{ #category : #accessing }
ToSkinManager >> installedSkinList [

	^ installedSkinList
]

{ #category : #accessing }
ToSkinManager >> newSkinList [

	^ newSkinList
]

{ #category : #'skin managing' }
ToSkinManager >> recordSkin: aSkin in: anElement [

	skinIndex at: anElement put: aSkin.
	newSkinList add: aSkin
]

{ #category : #accessing }
ToSkinManager >> skinIndex [

	^ skinIndex
]

{ #category : #'skin managing' }
ToSkinManager >> uninstallSkins [

	self installedSkinList do: [ :s | s launchUninstallation ].
]

{ #category : #'skin managing' }
ToSkinManager >> unrecordSkinIn: anElement [

	| skin |
	skin := skinIndex removeKey: anElement ifAbsent: [ ^ self ].
	newSkinList remove: skin
]
