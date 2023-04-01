Class {
	#name : #ToTheme,
	#superclass : #ToAbstractTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #testing }
ToTheme class >> default [

	^ ToClearTheme new
]

{ #category : #dresser }
ToTheme class >> dresserFor: aToElementClass [
	"return dresser which manage this theme"
	
	aToElementClass class = ToButton ifTrue:[
		^ ToLAFButtonDresser new
	].

	^ aToElementClass defaultDresser
]

{ #category : #testing }
ToTheme class >> isAbstract [

	^ self = ToTheme
]

{ #category : #skins }
ToTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"
	
	aToElementClass class = ToButton ifTrue:[
		^ OrderedCollection with: ToDefaultButtonSkin with: ToPrimaryButtonSkin with: ToDashedButtonSkin with: ToTextButtonSkin with: ToLinkButtonSkin
	].

	^ OrderedCollection new
]

{ #category : #border }
ToTheme >> borderRadius [
	"https://ant.design/components/button#design-token"
	
	^ 6
]

{ #category : #border }
ToTheme >> lineType [
	"https://ant.design/components/button#design-token"
	
	^ #solid
]

{ #category : #border }
ToTheme >> lineWidth [
	"https://ant.design/components/button#design-token"
	
	^ 1
]
