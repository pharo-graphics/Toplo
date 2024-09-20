Class {
	#name : #ToSkinManagerForTest,
	#superclass : #ToSkinManager,
	#instVars : [
		'skinInstalledCount'
	],
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #initialization }
ToSkinManagerForTest >> initialize [ 

	super initialize.
	skinInstalledCount := 0.
	skinStateQueue := ToSkinStateQueueForTest new
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManagerForTest >> installSkin: aSkin in: anElement [

	super installSkin: aSkin in: anElement.
	skinInstalledCount := skinInstalledCount + 1
]

{ #category : #accessing }
ToSkinManagerForTest >> skinInstalledCount [

	^ skinInstalledCount
]
