Trait {
	#name : #TToElement,
	#category : #'Toplo-Core'
}

{ #category : #'t - toElement' }
TToElement >> initializeForToplo [

	self ensureCanManageToploSkin
]

{ #category : #'t - toElement' }
TToElement >> installedSkinStateGenerator [

	^ self eventDispatcher handlers
		  detect: [ :h | h isKindOf: ToSkinStateGenerator ]
		  ifNone: [ ]
]

{ #category : #'t - toElement' }
TToElement >> menuPaneDo: aBlock [
	" introduced for compatibility with the popup window manager API"

	self flag: 'Check how to remove that'
]
