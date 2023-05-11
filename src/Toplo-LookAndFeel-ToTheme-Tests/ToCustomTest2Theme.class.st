Class {
	#name : #ToCustomTest2Theme,
	#superclass : #ToCustomNoDarkNoLightTestTheme,
	#category : #'Toplo-LookAndFeel-ToTheme-Tests-Themes'
}

{ #category : #skins }
ToCustomTest2Theme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"

	| oc |
	oc := OrderedCollection new.
	
	aToElementClass = ToButton ifTrue:[
		^ oc add: ToEmptyTestSkin; add: ToButtonTestSkin; yourself.
	].

	^ oc
]

{ #category : #properties }
ToCustomTest2Theme >> customPadding [

	^ nil
]
