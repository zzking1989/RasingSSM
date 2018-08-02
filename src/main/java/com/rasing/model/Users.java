package com.rasing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Users {
    private String id;

    private String userName;

    private String password;

    private int age;

    private String email;

}
