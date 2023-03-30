"
https://ant.design/docs/spec/dark

Dark mode is a theme where all UI elements are darkened.

When to use ?

    Dark mode is recommended when you are in a dark environment as it prevents eye strain.
    Dark mode is great for highlighting important content

        It works similarly to turning off the lights in a movie theater.
"
Class {
	#name : #ToDarkTheme,
	#superclass : #ToTheme,
	#category : #'Toplo-LookAndFeel-Theme'
}

{ #category : #colors }
ToDarkTheme >> backgroundColor [

	^ Color black
]

{ #category : #colors }
ToDarkTheme >> colorBgContainer [

	^ Color fromHexString: '#1b1b1b'
]

{ #category : #colors }
ToDarkTheme >> colorPrimary [
	
	^ Color fromHexString: '#1677ff'
]
