Class {
	#name : #ToButterflyTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-Demo-2 - ButterflyTheme'
}

{ #category : #testing }
ToButterflyTheme class >> canBeDefault [

	^ true
]

{ #category : #accessing }
ToButterflyTheme class >> label [

	^'Butterfly'
]

{ #category : #'skin creation' }
ToButterflyTheme >> defaultSkinFor: anElement [

	^ anElement defaultButterflySkin ifNil: [
		  super defaultSkinFor: anElement ]
]

{ #category : #'skin creation' }
ToButterflyTheme >> newSkinFor: anElement [

	^ anElement newButterflySkin
]
