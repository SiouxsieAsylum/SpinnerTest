package com.example.mcken.spinnertest;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.media.Image;
import android.support.v4.content.ContextCompat;
import android.support.v4.content.res.ResourcesCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import android.support.v7.view.menu.MenuBuilder;
import android.support.v7.view.menu.MenuPopupHelper;
import android.util.Log;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;




import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.PopupMenu;

import java.lang.reflect.Field;
import java.util.ArrayList;

import static com.example.mcken.spinnertest.R.color.postFocus;

//import java.awt.event.*;
//import java.awt.event.ActionEvent;
//import java.awt.event.ActionListener;


public class MainActivity extends AppCompatActivity {

    public ArrayList<Integer> viewArray;
    //public boolean flag;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        viewArray = new ArrayList<Integer>();
        //flag = true;

        RelativeLayout rl = (RelativeLayout) findViewById(R.id.activity_main);
        final int childcount = rl.getChildCount();

        for (int i = 0; i < childcount; i++){

            viewArray.add(rl.getChildAt(i).getId());

        }

    }

    //sets next imageview clickable
    public void clickableChange(){

        RelativeLayout rl = (RelativeLayout) findViewById(R.id.activity_main);
        final int childcount = rl.getChildCount();

        for (int i = 0; i < childcount - 1; i++){
            //viewArray collects the iD of all children in a layout.
             ImageView square = (ImageView) findViewById(viewArray.get(i));
             ImageView nextSquare = (ImageView) findViewById(viewArray.get(i+1));

            if (square.getDrawable() != null){
                nextSquare.setClickable(true);

                //set background to a resource color!!
                nextSquare.setBackgroundColor(ResourcesCompat.getColor(getResources(), R.color.postFocus, null));

                //set onClick listener to previously established method programmically
                nextSquare.setOnClickListener(new View.OnClickListener(){
                    @Override
                    public void onClick (View v){
                        imagePress(v);
                    }
                });

                Toast.makeText(getApplicationContext(), square.getId() + "is now clickable!", Toast.LENGTH_LONG).show();
            }
        }
    }

    public void imagePress(View test){
        int id = test.getId();
        ImageView picture = (ImageView) findViewById(id);

        final int pictureId = id;
//        final int nextId = viewArray.get(id + 1);


        picture.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ImageView empty = (ImageView) findViewById(pictureId);

                //if no already assigned drawable
                if (empty.getDrawable() == null){

                PopupMenu popup = new PopupMenu(MainActivity.this, view);
                popup.getMenuInflater().inflate(R.menu.popup_menu, popup.getMenu());


                popup.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    public boolean onMenuItemClick(MenuItem selection) {
                        ImageView thisThing = (ImageView) findViewById(pictureId);
                        Drawable icon = selection.getIcon();

                        thisThing.setImageDrawable(icon);
                        clickableChange();
                        return true;
                    }
                });

                popup.show();
                } else {
                    Toast.makeText(getApplicationContext(),"Image is already set!",Toast.LENGTH_LONG).show();
                }

            }
        });
    }
}

//we can now set each imageview to, when clicked, elicit a popup menu, set a resource, and make the
//next view clickable. This is fukkin fantastic. Now to put it into practice in MasterMind.