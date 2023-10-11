Class {
	#name : #ToSkinnableChildForTest,
	#superclass : #BlElement,
	#instVars : [
		'updateSkinCount'
	],
	#category : #'Toplo-Tests-Core-Slot'
}

{ #category : #initialize }
ToSkinnableChildForTest >> initialize [ 

	super initialize.
	updateSkinCount := 0
]

{ #category : #'t - skinable - initialization' }
ToSkinnableChildForTest >> updateSkin [ 

	updateSkinCount := updateSkinCount + 1
]

{ #category : #accessing }
ToSkinnableChildForTest >> updateSkinCount [

	^ updateSkinCount
]
